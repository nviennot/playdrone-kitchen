name "elasticsearch"
run_list "recipe[elasticsearch]",
         "recipe[elasticsearch::proxy]",
         "recipe[elasticsearch::plugins]"

override_attributes elasticsearch: {
  version: "0.90.0.RC2",
  cluster: { name: "google-play-crawler" },
  path:    { data: "/srv/elasticsearch",
             logs: "/var/log/elasticsearch" },
  nginx:   { users: [{username: "es-user", password: "es-password"}],
             allow_cluster_api: true },
  plugins: { 'karmi/elasticsearch-paramedic'        => {},
             'mobz/elasticsearch-head'              => {},
             'polyfractal/elasticsearch-inquisitor' => {}},
  'discovery.zen.ping.multicast.enabled' => false,
  'discovery.zen.ping.unicast.hosts'     => ["master", "secondary"]
}
