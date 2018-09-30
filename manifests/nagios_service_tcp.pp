# @summary Nagios TCP service monitoring
#
# @example monitoring a TCP service (exports a resource)
#   include nagios
#   nagios::nagios_service_tcp { "pgsql.megacorp.com": 
#     port => 5432,
#   }
# 
# @param local_ip Force using this IP address to test `site_name`, otherwise
#   use the default machine hostname
# @param site_name VHost name of HTTP site to test with `check_tcp`
# @param port TCP port to monitor with `check tcp`
# @param service Nagios service to restart if needed
define nagios::nagios_service_tcp(
    Optional[String]  $local_ip   = $nagios::local_ip,
    String            $site_name  = $title,
    Integer           $port       = 80,
    String            $service    = $nagios::service,
) {

  $_local_ip = pick($local_ip, $facts['fqdn'])

  @@nagios_service { "${facts['fqdn']}_tcp_${site_name}":
    ensure              => present,
    use                 => 'generic-service',
    host_name           => $facts['fqdn'],
    service_description => "${facts['fqdn']}_tcp_${site_name}",
    check_command       => "check_tcp!${port}",
    notify              => Service[$service],
  }

}
