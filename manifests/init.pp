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
# * `collect`
# True if should collect and realize all nagios resources and tagged 
# configuration files
# * `monitor_tag`
# Plaintext tag for nagios configuration files we should collect
# * `apache_conf_dir`
# Directory to write apache configuration files to
# * `htpasswd`
# Full path to .htpasswd file
# * `password`
# Password for the nagios user
# * `realm`
# Directory to manage passwords for (`/nagios`)
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
    $collect          = true,
    $monitor_tag      = "__MONITOR__",
    $apache_conf_dir  = $nagios::params::apache_conf_dir,
    $htpasswd         = $nagios::params::htpasswd,
    $password         = "changeme",
    $realm            = "/nagios",
    $service          = $nagios::params::service,
    $local_ip         = undef,
    $nagios_server    = undef,
) inherits ::nagios::params {

}
