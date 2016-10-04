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
) inherits ::nagios::params {
  $service = $nagios::params::service
  $packages = $nagios::params::packages
  $nagios_conf_dir = $nagios::params::nagios_conf_dir
  $apache_group = $nagios::params::apache_group
  $apache_conf = "${apache_conf_dir}/${service}.conf"
  $nagios_cfg_file = $nagios::params::nagios_cfg_file
  $nagios_group = $nagios::params::nagios_group

  include epel
  require ::apache
  require ::apache::mod::php

  package { $packages:
    ensure  => present,
    require => Class['epel'],
  }

  file { "${nagios_conf_dir}/conf.d":
    ensure  => directory,
    owner   => 'nagios',
    group   => 'nagios',
    mode    => '0755',
    require => Package[$packages],
  }

  httpauth { 'nagiosadmin':
    file      => $htpasswd,
    password  => $password,
    realm     => $realm,
    mechanism => 'basic',
    ensure    => present,
  }

  file { $htpasswd:
    ensure => file,
    owner  => 'root',
    group  => $apache_group,
    mode   => '0640',
  }

  file { $apache_conf:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/nagios_${osfamily}.conf.erb"),
    notify  => Service['httpd']
  }

  service { $service:
    ensure    => running,
    enable    => true,
    subscribe => File[$apache_conf],
  }

  if $collect {
    File <<| tag == $monitor_tag |>>

    # collects to /etc/nagios/nagios_host.cfg, set by the type and provider
    Nagios_host <<||>>

    # collects to /etc/nagios/nagios_service.cfg, set by the type and provider
    Nagios_service <<||>>

    # Tell nagios about the above settings
    file_line { "puppet_nagios_host":
      path   => $nagios_cfg_file,
      ensure => present,
      line   => 'cfg_file=nagios_host.cfg',
      notify => Service[$service],
    }

    file_line { "puppet_nagios_service":
      path   => $nagios_cfg_file,
      ensure => present,
      line   => 'cfg_file=nagios_service.cfg',
      notify => Service[$service],
    }

    # fix permissions on puppet-generated cfg files
    file { ['/etc/nagios/nagios_host.cfg', '/etc/nagios/nagios_service.cfg']:
      ensure => file,
      owner  => 'root',
      group  => $nagios_group,
      mode   => '0640',
      notify => Service[$service],
    }
  }
}
