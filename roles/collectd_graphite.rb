name "collectd_graphite"
run_list "recipe[collectd_graphite]"

# This is just the collectd client
# for the graphite setup, see graphite.rb

default_attributes collectd: {
  interval: 10
}, collectd_graphite: {
  host: 'monitor',
  port: '2003',
}
