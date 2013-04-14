# Monkey patch to suppress warning
def create_rvm_chef_user_environment
  klass = Class.new(::RVM::Environment) do
    attr_reader :user, :source_environment

    def initialize(user = nil, environment_name = "default", options = {})
      @source_environment = options.delete(:source_environment)
      @source_environment = true if @source_environment.nil?
      @user = user
      # explicitly set rvm_path if user is set
      if @user.nil?
        config['rvm_path'] = $root_rvm_path
      else
        config['rvm_path'] = File.join(Etc.getpwnam(@user).dir, '.rvm')
      end

      merge_config! options
      @environment_name = environment_name
      @shell_wrapper = ::RVM::Shell::ChefWrapper.new(@user)
      @shell_wrapper.setup do |s|
        if source_environment
          source_rvm_environment
          use_rvm_environment
        end
      end
    end

    def self.root_rvm_path=(path)
      # class variable warning. This is worse but it silent the warning.
      $root_rvm_path = path
    end
  end
  ::RVM.const_set('ChefUserEnvironment', klass)

  ::RVM::ChefUserEnvironment.root_rvm_path = node['rvm']['root_path']
end
