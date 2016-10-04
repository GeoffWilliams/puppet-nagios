define nagios::nagios_service_http(
    $local_ip       = $nagios::local_ip,
    $site_name      = $title,
    $port           = 80,
    $nagios_server  = $nagios::nagios_server,
    $url            = '',
) {

  if $local_ip {
    $_local_ip = $local_ip
  } else { 
    $_local_ip = $fqdn
  }

  @@nagios_service { "${::fqdn}_http_${site_name}":
    ensure              => present,
    use                 => 'generic-service',
    host_name           => $::fqdn,
    service_description => "${::fqdn}_http_${site_name}",
    check_command       => "check_http!${site_name} -I ${_local_ip} -p ${port} -u http://${site_name}${url}",
    notify              => Service[$nagios::service],
  }

}
