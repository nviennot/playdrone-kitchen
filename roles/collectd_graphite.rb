name "collectd_graphite"
run_list "recipe[collectd_graphite]"

# This is just the collectd client
# for the graphite setup, see graphite.rb

override_attributes collectd: {
  interval: 1
}, collectd_graphite: {
  host: 'master',
  port: '2003',
}
