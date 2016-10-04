# Class: nagios
# ===========================
#
# Full description of class nagios here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `local_ip`
# IP address of the server being monitored
#
# * `service`
# Name of the nagios service to restart
#
# Authors
# -------
#
# Brett Gray
# Geoff Williams
#
# Copyright
# ---------
#
# Copyright 2016 Puppet, Inc.
#
class nagios(
    $local_ip = undef,
    $service  = $nagios::params::service,
) {

}
