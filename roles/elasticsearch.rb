name "elasticsearch"
run_list "recipe[oracle_jdk_8]",
         "recipe[elasticsearch]",
         "recipe[elasticsearch::proxy]",
         "recipe[elasticsearch::plugins]"

default_attributes elasticsearch: {
  version: "1.3.1",
  cluster: { name: "playdrone" },
  path:    { data: "/srv/elasticsearch",
             logs: "/var/log/elasticsearch" },
  nginx:   { users: [{username: "user", password: "password"}],
             allow_cluster_api: true },
  plugins: { 'karmi/elasticsearch-paramedic' => {},
             'mobz/elasticsearch-head'       => {},
             'lmenezes/elasticsearch-kopf'   => {}},
  'discovery.zen.ping.multicast.enabled' => false,
  'discovery.zen.ping.unicast.hosts'     => ["master", "secondary"]
}, iptables: {
  services: { elasticsearch_http: 8080 }
}
