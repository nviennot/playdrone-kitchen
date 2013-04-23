name "graphite"
run_list "recipe[apache2]",
         "recipe[graphite]",
         "recipe[graphite::carbon_upstart]",
         "recipe[apache_auth]",
         "recipe[statsd]"

default_attributes apache: {
  listen_ports: [80]
}, iptables: {
  services: { graphite_http: 80 }
}, apache_auth: [{
  htpasswd_file: '/etc/apache2/htpasswd',
  htaccess_file: '/srv/graphite/webapp/.htaccess',
  user: 'user',
  password: 'password'
}], graphite: {
  listen_port: 80,
  carbon: { service_type: 'upstart' },
  base_dir: "/srv/graphite",
  doc_root: "/srv/graphite/webapp",
  storage_dir: "/srv/graphite/storage",
  timezone: 'America/New_York',
  storage_schemas: [{ name: 'catchall',
                      pattern: '^.*',
                      retentions: '10s:30d,1m:120d,1h:1y' }]
}, statsd: {
  flush_interval: 10000
}
