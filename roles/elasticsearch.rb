name "elasticsearch"
run_list "recipe[oracle_jdk_7]",
         "recipe[elasticsearch]",
         "recipe[elasticsearch::proxy]",
         "recipe[elasticsearch::plugins]"

default_attributes elasticsearch: {
  version: "0.90.7",
  cluster: { name: "google-play-crawler" },
  path:    { data: "/srv/elasticsearch",
             logs: "/var/log/elasticsearch" },
  nginx:   { users: [{username: "user", password: "password"}],
             allow_cluster_api: true },
  plugins: { 'karmi/elasticsearch-paramedic'        => {},
             'mobz/elasticsearch-head'              => {},
             'polyfractal/elasticsearch-inquisitor' => {}},
  'discovery.zen.ping.multicast.enabled' => false,
  'discovery.zen.ping.unicast.hosts'     => ["master", "secondary"]
}, iptables: {
  services: { elasticsearch_http: 8080 }
}
