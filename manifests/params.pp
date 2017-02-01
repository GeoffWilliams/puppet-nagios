# Nagios::Params
#
# Params pattern for nagios module
class nagios::params {
  case $osfamily {
    'RedHat': {
      $apache_conf_dir = '/etc/httpd/conf.d'
      $service = 'nagios'
      $packages = [$service,'nagios-plugins','nagios-plugins-all']
      $apache_group = "apache"
      $nagios_group = 'nagios'
    }
    'Debian': {
      # https://tickets.puppetlabs.com/browse/MODULES-3116
      # $apache_conf_dir = '/etc/apache2/conf-available/'
      $apache_conf_dir = '/etc/apache2/conf.d'
      $service = 'nagios3'
      $packages = [$service, 'monitoring-plugins']
      $apache_group = "www-data"
      $nagios_group = 'nagios'
    }
    default: {
      notify { "module ${module_name} doesn't support ${osfamily} yet":}
    }
  }
  $nagios_conf_dir = "/etc/${service}"
  $htpasswd = "${nagios_conf_dir}/nagios.htpasswd"
  $nagios_cfg_file = "${nagios_conf_dir}/nagios.cfg"
  $port = 80
}
