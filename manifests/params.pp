class nagios::params {
  case $osfamily {
    "RedHat": {
      $apache_conf_dir = "/etc/httpd/conf.d"
      $packages = ['nagios','nagios-plugins','nagios-plugins-all']
      $service = 'nagios'
    }
    "Debian": {
      $apache_conf_dir = "/etc/apache2/conf.d"
      $packages = ['nagios3', 'monitoring-plugins']
      $service = 'nagios3'
    }
    default: {
      notify { "module ${module_name} doesn't support ${osfamily} yet":}
    }
  }
  $htpasswd = "/etc/nagios/nagios.htpasswd"
}
