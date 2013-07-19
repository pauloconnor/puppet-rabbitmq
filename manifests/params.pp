# Class: rabbitmq::params
#
#   The RabbitMQ Module configuration settings.
#
class rabbitmq::params {

  case $::osfamily {
    'Debian': {
      $package_ensure   = 'installed'
      $package_name     = 'rabbitmq-server'
      $package_provider = 'apt'
      $package_source   = false
      $version          = '3.1.3'
    }
    'RedHat': {
      $package_ensure   = 'installed'
      $package_name     = 'rabbitmq-server'
      $package_provider = 'rpm'
      $version          = '3.1.3-1'
      $base_version     = regsubst($version,'^(.*)-\d$','\1')
      # This must remain at the end as we need $base_version and $version defined first.
      $package_source   = "http://www.rabbitmq.com/releases/rabbitmq-server/v${base_version}/rabbitmq-server-${version}.noarch.rpm"
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

  #install
  $admin_enable             = true
  $erlang_manage            = false
  $management_port          = '15672'
  $service_ensure           = 'running'
  $service_manage           = true
  $service_name             = 'rabbitmq-server'
  #config
  $cluster_disk_nodes       = false
  $cluster_node_type        = 'disc'
  $cluster_nodes            = []
  $config                   = 'rabbitmq/rabbitmq.config.erb'
  $config_cluster           = false
  $config_mirrored_queues   = false
  $config_path              = '/etc/rabbitmq/rabbitmq.config'
  $config_stomp             = false
  $delete_guest_user        = false
  $env_config               = 'rabbitmq/rabbitmq-env.conf.erb'
  $env_config_path          = '/etc/rabbitmq/rabbitmq-env.conf'
  $erlang_cookie            = 'EOKOWXQREETZSHFNTPEY'
  $manage_service           = true
  $node_ip_address          = 'UNSET'
  $plugin_dir               = "/usr/lib/rabbitmq/lib/rabbitmq_server-${version}/plugins"
  $port                     = '5672'
  $stomp_port               = '6163'
  $wipe_db_on_cookie_change = false

}
