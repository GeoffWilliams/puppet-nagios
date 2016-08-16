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
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class nagios(
    $collect          = true,
    $monitor_tag      = "__MONITOR__",
    $apache_conf_dir  = $nagios::params::apache_conf_dir,
    $htpasswd         = $nagios::params::htpasswd,
    $password         = "changeme",
    $realm            = "/nagios",
) inherits nagios::params {

  include epel
  require ::apache
  require ::apache::mod::php

  package { $nagios::params::packages:
    ensure  => present,
    require => Class['epel'],
  }

  file { '/etc/nagios/conf.d':
    ensure  => directory,
    owner   => 'nagios',
    group   => 'nagios',
    mode    => '0755',
    require => Package['nagios'],
  }

  httpauth { 'nagios':
    file      => $htpasswd,
    password  => $password,
    realm     => $realm,
    mechanism => 'basic',
    ensure    => present,
  }

  file { $htpasswd:
    ensure => file,
    owner  => 'root',
    group  => 'apache',
    mode   => '0640',
  }

  file { "${apache_conf_dir}/nagios.conf":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/nagios.conf.erb"),
    require => Package['nagios'],
  }

  service { 'nagios':
    ensure    => running,
    enable    => true,
    subscribe => File["${apache_conf_dir}/nagios.conf"],
  }

  if $collect {
    File <<| tag == $monitor_tag |>>
    Nagios_host <<||>>
    Nagios_service <<||>>
  }
}
