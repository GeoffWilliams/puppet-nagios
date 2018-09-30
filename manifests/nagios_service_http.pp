# @summary Nagios HTTP service monitoring
#
# @example monitoring a HTTP service (exports a resource)
#   include nagios
#   nagios::nagios_service_http { "test.megacorp.com": }
# 
# @param local_ip Force using this IP address to test `site_name`, otherwise
#   use the default machine hostname
# @param site_name VHost name of HTTP site to test with `check_http`
# @param url URL within site to test with `check_http`
# @param service Nagios service to restart if needed
define nagios::nagios_service_http(
    Optional[String]  $local_ip   = $nagios::local_ip,
    String            $site_name  = $title,
    Integer           $port       = 80,
    String            $url        = '',
    String            $service    = $nagios::service,
) {

  $_local_ip = pick($local_ip, $facts['fqdn'])

  @@nagios_service { "${facts['fqdn']}_http_${site_name}":
    ensure              => present,
    use                 => 'generic-service',
    host_name           => $facts['fqdn'],
    service_description => "${facts['fqdn']}_http_${site_name}",
    check_command       => "check_http!${site_name} -I ${_local_ip} -p ${port} -u http://${site_name}${url}",
    notify              => Service[$service],
  }

}
