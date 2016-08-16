class nagios::params {
  case $osfamily {
    "RedHat": {
      $apache_conf_dir = "/etc/httpd/conf.d"
      $service = 'nagios'
      $packages = [$service,'nagios-plugins','nagios-plugins-all']
    }
    "Debian": {
      $apache_conf_dir = "/etc/apache2/conf.d"
      $service = 'nagios3'
      $packages = [$service, 'monitoring-plugins']
    }
    default: {
      notify { "module ${module_name} doesn't support ${osfamily} yet":}
    }
  }
  $nagios_conf_dir = "/etc/${service}"
  $htpasswd = "${nagios_conf_dir}/nagios.htpasswd"
}
