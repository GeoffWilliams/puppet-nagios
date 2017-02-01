# Nagios::Nagios_service_tcp
#
# Nagios TCP service monitoring
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
    service_description => "${::fqdn}_tcp_${site_name}",
    check_command       => "check_tcp!${port}",
    notify              => Service[$nagios::service],
  }

}
