class nagios::params {
  case $osfamily {
    "RedHat": {
      $apache_conf_dir = "/etc/httpd/conf.d"
      $packages = ['nagios','nagios-plugins','nagios-plugins-all']
    }
    "Debian": {
      $apache_conf_dir = "/etc/apache2/conf.d"
      $packages = ['nagios3', 'monitoring-plugins']
    }
    default: {
      notify { "module ${module_name} doesn't support ${osfamily} yet":}
    }
  }
  $htpasswd = "/etc/nagios/nagios.htpasswd"
}
