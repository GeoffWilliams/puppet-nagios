# @summary Main class to load defaults
#
# @example Set class level variables to defaults
#   include nagios
#
# @example Set custom class variables
#   class { "nagios":
#     local_ip => "192.168.1.120",
#     service  => "nagios-x",
#   }
#
# **Authors**
# * Brett Gray
# * Geoff Williams
#
# **Copyright**
# Copyright 2016 Puppet, Inc.
#
# @param local_ip IP address of the server being monitored
# @param service Name of the nagios service to restart
class nagios(
    Optional[String]  $local_ip = undef,
    String            $service  = $nagios::params::service,
) inherits nagios::params {

}
