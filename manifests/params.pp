class nagios::params {
  case $osfamily {
    "RedHat": {
      $apache_conf_dir = "/etc/httpd/conf.d"
      $packages = ['nagios','nagios-plugins','nagios-plugins-all']
      $htpasswd = "/etc/nagios/nagios.htpasswd"
    }
    default: {
      notify { "module ${module_name} doesn't support ${osfamily} yet":}
    }
  }  
}
