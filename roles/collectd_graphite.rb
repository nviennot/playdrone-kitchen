name "collectd_graphite"
run_list "recipe[collectd_graphite]"

override_attributes collectd: {
  interval: 1
}, collectd_graphite: {
  host: 'master',
  port: '2003',
}
