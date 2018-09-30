# @summary Install a nagios server
#
# **Authors**
# Brett Gray
# Geoff Williams
#
# **Copyright**
# Copyright 2016 Puppet, Inc.
#
# @param collect
#   True if should collect and realize all nagios resources and tagged
#   configuration files
# @param monitor_tag
#   Plaintext tag for nagios configuration files we should collect
# @param apache_conf_dir
#   Directory to write apache configuration files to
# @param htpasswd
#   Full path to .htpasswd file
# @param password
#   Password for the nagios user
# @param realm
#   Directory to manage passwords for (`/nagios`)
# @param service
#   Nagios service name
# @param purge
#   Purge unmanaged `nagios_service`, `nagios_host` resources
class nagios::server(
    Boolean $collect          = true,
    String  $monitor_tag      = "__MONITOR__",
    String  $apache_conf_dir  = $nagios::params::apache_conf_dir,
    String  $htpasswd         = $nagios::params::htpasswd,
    String  $password         = "changeme",
    String  $realm            = "/nagios",
    String  $service          = $nagios::params::service,
    Boolean $purge            = true,
) inherits nagios::params {
  if ! defined(Class['nagios']) {
    fail('You must include the nagios base class before using the nagios::server class')
  }

  $packages         = $nagios::params::packages
  $nagios_conf_dir  = $nagios::params::nagios_conf_dir
  $apache_group     = $nagios::params::apache_group
  $apache_conf      = "${apache_conf_dir}/${service}.conf"
  $nagios_cfg_file  = $nagios::params::nagios_cfg_file
  $nagios_group     = $nagios::params::nagios_group

  include epel

  if $purge {
    resources{ 'nagios_service':
      purge => true
    }
    resources{ 'nagios_host':
      purge => true
    }
  }

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
    ensure    => present,
    file      => $htpasswd,
    password  => $password,
    realm     => $realm,
    mechanism => 'basic',
    require   => Package[$packages],
  }

  file { $htpasswd:
    ensure  => file,
    owner   => 'root',
    group   => $apache_group,
    mode    => '0640',
    require => Package[$packages],
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
    Nagios_host <||> {
      require => Package[$packages],
    }

    # collects to /etc/nagios/nagios_service.cfg, set by the type and provider
    Nagios_service <<||>>
    Nagios_service <||> {
      require => Package[$packages],
    }

    # Tell nagios about the above settings
    file_line { "puppet_nagios_host":
      ensure  => present,
      path    => $nagios_cfg_file,
      line    => 'cfg_file=nagios_host.cfg',
      notify  => Service[$service],
      require => Package[$packages],
    }

    file_line { "puppet_nagios_service":
      ensure  => present,
      path    => $nagios_cfg_file,
      line    => 'cfg_file=nagios_service.cfg',
      notify  => Service[$service],
      require => Package[$packages],
    }

    # fix permissions on puppet-generated cfg files
    file { ['/etc/nagios/nagios_host.cfg', '/etc/nagios/nagios_service.cfg']:
      ensure  => file,
      owner   => 'root',
      group   => $nagios_group,
      mode    => '0640',
      notify  => Service[$service],
      require => Package[$packages],
    }
  }

}
