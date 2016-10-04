define nagios::nagios_service_tcp(
    $local_ip       = $nagios::local_ip,
    $site_name      = $title,
    $port           = 80,
    $service        = $nagios::service,
) {

  if $local_ip {
    $_local_ip = $local_ip
  } else { 
    $_local_ip = $fqdn
  }

  @@nagios_service { "${::fqdn}_tcp_${site_name}":
    ensure              => present,
    use                 => 'generic-service',
    host_name           => $::fqdn,
    service_description => "${::fqdn}_http_${site_name}",
    check_command       => "check_tcp!${site_name} -H ${_local_ip} -p ${port}",
    notify              => Service[$nagios::service],
  }

}
