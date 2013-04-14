site :opscode

cookbook "java", :git => 'git://github.com/sroccaserra/java.git'

cookbook "elasticsearch"
cookbook "graphite", :git => 'git://github.com/nviennot/graphite.git'
cookbook "collectd", :git => 'git://github.com/coderanger/chef-collectd.git'

# cookbook 'rvm',      :git => 'git://github.com/fnichol/chef-rvm.git'

cookbook 'base',              :path => 'site-cookbooks/base'
cookbook 'hosts',             :path => 'site-cookbooks/hosts'
cookbook 'ssd',               :path => 'site-cookbooks/ssd'
cookbook 'mongodb',           :path => 'site-cookbooks/mongodb'
cookbook 'glusterfs',         :path => 'site-cookbooks/glusterfs'
cookbook "collectd_graphite", :path => 'site-cookbooks/collectd_graphite'
