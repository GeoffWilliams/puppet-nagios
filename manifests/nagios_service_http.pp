define nagios::nagios_service_http(
    $ip_address,
    $site_name=$title,
    $website_port = 80,
) {

  @@nagios_service { "${::fqdn}_http_${service_name}":
    ensure              => present,
    use                 => 'generic-service',
    host_name           => $::fqdn,
    service_description => "${::fqdn}_http_${site_name}",
    check_command       => "check_http!${site_name} -I ${ip_address} -p ${website_port} -u http://${site_name}",
    notify              => Service[$nagios::service],
  }

}
