include_attribute "java"

default[:java][:install_flavor] = "oracle"
default[:java][:oracle][:accept_oracle_download_terms] = true
default[:java][:jdk_version] = 7
