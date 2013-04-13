class Chef::ResourceDefinitionList::MongoDB
  def self.configure_replicaset(node, name)
    ENV['TEST_MODE'] = '1'
    # lazy require, to move loading this modules to runtime of the cookbook
    require 'rubygems'
    require 'mongo'

    begin
      connection = Mongo::Connection.new('localhost', node['mongodb']['port'], :op_timeout => 5, :slave_ok => true)
    rescue
      Chef::Log.warn("Could not connect to database: 'localhost:#{node['mongodb']['port']}'")
      return
    end

    hosts = node['mongodb']['hosts']

    # Want the node originating the connection to be included in the replicaset
    rs_members = []
    hosts.each_index do |n|
      port = node['mongodb']['port']
      rs_members << {"_id" => n, "host" => "#{hosts[n]}:#{port}"}
    end

    admin = connection['admin']
    cmd = BSON::OrderedHash.new
    cmd['replSetInitiate'] = {
        "_id" => name,
        "members" => rs_members
    }

    begin
      result = admin.command(cmd, :check_response => false)
    rescue Mongo::OperationTimeout
      Chef::Log.info("Started configuring the replicaset, this will take some time, another run should run smoothly")
      return
    end
    if result.fetch("ok", nil) == 1
      # everything is fine, do nothing
    elsif result.fetch("errmsg", nil) == "already initialized"
      # check if both configs are the same
      config = connection['local']['system']['replset'].find_one({"_id" => name})
      if config['_id'] == name and config['members'] == rs_members
        # config is up-to-date, do nothing
        Chef::Log.info("Replicaset '#{name}' already configured")
      else
        # remove removed members from the replicaset and add the new ones
        max_id = config['members'].collect{ |member| member['_id']}.max
        rs_members.collect!{ |member| member['host'] }
        config['version'] += 1
        old_members = config['members'].collect{ |member| member['host'] }
        members_delete = old_members - rs_members
        config['members'] = config['members'].delete_if{ |m| members_delete.include?(m['host']) }
        members_add = rs_members - old_members
        members_add.each do |m|
          max_id += 1
          config['members'] << {"_id" => max_id, "host" => m}
        end

        rs_connection = Mongo::ReplSetConnection.new( *old_members.collect{ |m| m.split(":") })
        admin = rs_connection['admin']

        cmd = BSON::OrderedHash.new
        cmd['replSetReconfig'] = config

        result = nil
        begin
          result = admin.command(cmd, :check_response => false)
        rescue Mongo::ConnectionFailure
          # reconfiguring destroys exisiting connections, reconnect
          Mongo::Connection.new('localhost', node['mongodb']['port'], :op_timeout => 5, :slave_ok => true)
          config = connection['local']['system']['replset'].find_one({"_id" => name})
          Chef::Log.info("New config successfully applied: #{config.inspect}")
        end
        if !result.nil?
          Chef::Log.error("configuring replicaset returned: #{result.inspect}")
        end
      end
    elsif !result.fetch("errmsg", nil).nil?
      Chef::Log.error("Failed to configure replicaset, reason: #{result.inspect}")
    end
  end
end
