define nagios::nagios_service_http(
    $local_ip       = undef,
    $site_name      = $title,
    $port           = 80,
    $nagios_server  = undef,
    $url            = '',
) {

  if $local_ip {
    if $nagios_server {

      # effective on the SECOND puppet run after above resource processed...
      $local_ip = $source_ipaddress[$nagios_server]
    } else {
      $local_ip = $fqdn
    }
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
