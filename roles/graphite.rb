name "graphite"
run_list "recipe[apache2]",
         "recipe[graphite]",
         "recipe[graphite::carbon_upstart]"

override_attributes apache: {
  listen_ports: [8000]
}, graphite: {
  listen_port: 8000,
  carbon: { service_type: 'upstart' },
  # storage_dir: '/srv/graphite', # That thing doesn't really work :(
  timezone: 'America/New_York',
  storage_schemas: [{ name: 'catchall',
                      pattern: '^.*',
                      retentions: '1s:1d' }]
  # storage_schemas: [{ name: 'catchall',
                      # pattern: '^.*',
                      # retentions: '1s:30d,1m:120d,1h:1y' }]
}
