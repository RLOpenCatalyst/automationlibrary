# This is a definition used to generate a php application structure
# according to the given parameters

define :php_application, enable: true do

  application_name = params[:name]

  application_config = params[:application_config] || {}

  # Define needs for this php application
  options = Chef::Mash.new(
      {
          basedir: "#{node[:php_applications][:apps_path]}/#{application_name}",
          owner: node[:php_applications][:user],
          group: node[:php_applications][:group],
          canonical_hostname: application_name,
          capistrano: false,
          zend_framework: false,
          mysql: false,
          users: [],
          document_root: nil,
          # Used to change php settings through attributes
          php_values: {},
          php_admin_values: {},
          php_flags: {},
          php_admin_flags: {},
      }).merge(application_config)

  # Create application folder
  directory options[:basedir] do
    owner options[:owner]
    group options[:group]
    mode '2770'
  end

  # add users to application group
  group options[:group] do
    members options[:users]
    append true
    only_if { options[:users].any? }
  end

  # Warn if apache user can't access directory
  unless options[:users].include?(node[:apache][:user]) || options[:group] == node[:apache][:group]
    Chef::Log.warn("Base directory belongs to #{options[:group]}, apache user '#{node[:apache][:user]}' won't be able to access it")
  end

  # Create mysql user for application if required
  if (mysql_data = options[:mysql])
    # require the gem to create users
    include_recipe 'database::mysql'
    # This is required since mysql root password might be initialized later from an encrypted data bag
    node.set_unless[:php_applications][:mysql_admin_credentials][:password] = node[:mysql][:server_root_password]
    # grant privileges to the given user on the given database
    mysql_database_user mysql_data[:username] do
      # Get credentials from json or uses cookbook default
      connection mysql_data[:connection] || node[:php_applications][:mysql_admin_credentials]
      password mysql_data[:password]
      database_name mysql_data[:database]
      # use provided or defaults if nil
      host mysql_data[:host]
      privileges mysql_data[:privileges]
      action :grant
    end
  end

  # Application variables
  application_path = File.join(node[:php_applications][:apps_path], application_name)
  if options[:document_root]
    document_root = options[:document_root]
  else
    # Webserver document root, optionally using capistrano for deployments
    document_root = options[:capistrano] ? File.join(application_path, 'current') : application_path
    # If it's a ZF application use public folder as document root
    document_root = File.join(document_root, 'public') if options[:zend_framework]
  end

  # Support for ssl
  if options[:ssl]
    # TODO needs testing
    include_recipe 'ssl'
    apache_module :ssl
  end

  # Apache definition to create a virtual host
  web_app application_name do
    template 'apache_vhost.conf.erb'
    # Use this cookbook to localize template
    cookbook 'lamp_role'
    # any param given here is forwarded to the template under params hash
    server_name application_name
    server_aliases options[:aliases] if options[:aliases] && options[:aliases].any?
    document_root document_root
    allow_override 'All'
    # Apache virtual host based on port if given (default 80)
    port !options[:ssl] ? node[:apache][:listen_ports].first : node[:apache][:listen_ports].last
    # SSL support in template
    ssl options[:ssl]
    # SSL certificate base name as used in ssl recipe
    ssl_cert options[:ssl_cert].gsub('_', '.') if options[:ssl_cert]
    # ZF app environment configuration
    if options[:zend_framework] && options[:zend_framework][:environment]
      application_environment options[:zend_framework][:environment]
    end
    # Conditional support for canonical hostname
    canonical_hostname options[:canonical_hostname]
    # Give template the list of php directives to configure
    php_values options[:php_values]
    php_admin_values options[:php_admin_values]
    php_flags options[:php_flags]
    php_admin_flags options[:php_admin_flags]
  end

end
