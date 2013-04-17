apt_repository_glusterfs

package "glusterfs-server"

prefix = node[:glusterfs][:server][:prefix]
num_replica = node[:glusterfs][:server][:replica].to_i

# XXX This might work only with chef-solo
current_host = ([node[:hostname], node[:fqdn], node[:ipaddress]] & node[:glusterfs][:peers]).first
raise "Node not in the peer list (#{node[:glusterfs][:peers]})" unless current_host

directory prefix do
  recursive true
end

node[:glusterfs][:peers].each do |peer|
  execute "gluster peer probe #{peer} || true" unless current_host == peer
end

node[:glusterfs][:server][:volumes].each do |volume|
  all_bricks = node[:glusterfs][:peers].map { |peer| "#{peer}:#{prefix}/#{volume}" }
  current_brick = "#{current_host}:#{prefix}/#{volume}"

  if current_brick == all_bricks.first
    execute "gluster volume create #{volume} #{current_brick}" do
      not_if "gluster volume info #{volume}"
    end

    execute "gluster volume start #{volume}" do
      not_if "gluster volume info #{volume} | grep 'Status: Started'"
    end
  end

  ruby_block "maybe add bricks" do
    block do
      cmd = Mixlib::ShellOut.new("gluster volume info | grep '^Brick.*: ' | cut -d' ' -f2-")
      cmd.run_command
      cmd.error!
      running_bricks = cmd.stdout.split("\n")

      bricks_to_add = all_bricks - running_bricks
      if bricks_to_add.include? current_brick
        cmd = if running_bricks.size < num_replica
          # bootstrapping initial node, adding a single brick is okay
          "gluster volume add-brick #{volume} replica #{num_replica} #{current_brick}"
        else
          "gluster volume add-brick #{volume} replica #{num_replica} #{bricks_to_add.join(' ')}"
        end

        cmd = Mixlib::ShellOut.new(cmd)
        cmd.run_command
        cmd.error!
      end
    end

    only_if "gluster volume info #{volume}"
  end
end
