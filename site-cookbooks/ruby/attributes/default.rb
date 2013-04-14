include_attribute 'rvm'

default[:rvm][:default_ruby]      = "ruby-1.9.3-p327"
default[:rvm][:user_default_ruby] = "ruby-1.9.3-p327"

default[:rvm][:rubies] = [
  {
    'version' => 'ruby-1.9.3-p327',
    'ruby_string' => 'ruby-1.9.3-p327',
    'patch'   => 'falcon',
  }
]

default[:rvm][:rvmrc] = {
  'rvm_project_rvmrc'             => 1,
  'rvm_gemset_create_on_use_flag' => 1,
  'rvm_trust_rvmrcs_flag'         => 1,
  'RUBY_HEAP_MIN_SLOTS'           => 1000000,
  'RUBY_HEAP_SLOTS_INCREMENT'     => 1000000,
  'RUBY_HEAP_SLOTS_GROWTH_FACTOR' => 1,
  'RUBY_GC_MALLOC_LIMIT'          => 100000000,
  'RUBY_HEAP_FREE_MIN'            => 500000,
}
