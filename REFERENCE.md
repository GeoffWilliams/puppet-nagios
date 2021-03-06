# Reference
<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

**Classes**

* [`nagios`](#nagios): Main class to load defaults
* [`nagios::params`](#nagiosparams): Params pattern for nagios module
* [`nagios::server`](#nagiosserver): Install a nagios server

**Defined types**

* [`nagios::nagios_service_http`](#nagiosnagios_service_http): Nagios HTTP service monitoring
* [`nagios::nagios_service_tcp`](#nagiosnagios_service_tcp): Nagios TCP service monitoring

## Classes

### nagios

**Authors**
* Brett Gray
* Geoff Williams

**Copyright**
Copyright 2016 Puppet, Inc.

#### Examples

##### Set class level variables to defaults

```puppet
include nagios
```

##### Set custom class variables

```puppet
class { "nagios":
  local_ip => "192.168.1.120",
  service  => "nagios-x",
}
```

#### Parameters

The following parameters are available in the `nagios` class.

##### `local_ip`

Data type: `Optional[String]`

IP address of the server being monitored

Default value: `undef`

##### `service`

Data type: `String`

Name of the nagios service to restart

Default value: $nagios::params::service

### nagios::params

Params pattern for nagios module

### nagios::server

**Authors**
Brett Gray
Geoff Williams

**Copyright**
Copyright 2016 Puppet, Inc.

#### Parameters

The following parameters are available in the `nagios::server` class.

##### `collect`

Data type: `Boolean`

True if should collect and realize all nagios resources and tagged
configuration files

Default value: `true`

##### `monitor_tag`

Data type: `String`

Plaintext tag for nagios configuration files we should collect

Default value: "__MONITOR__"

##### `apache_conf_dir`

Data type: `String`

Directory to write apache configuration files to

Default value: $nagios::params::apache_conf_dir

##### `htpasswd`

Data type: `String`

Full path to .htpasswd file

Default value: $nagios::params::htpasswd

##### `password`

Data type: `String`

Password for the nagios user

Default value: "changeme"

##### `realm`

Data type: `String`

Directory to manage passwords for (`/nagios`)

Default value: "/nagios"

##### `service`

Data type: `String`

Nagios service name

Default value: $nagios::params::service

##### `purge`

Data type: `Boolean`

Purge unmanaged `nagios_service`, `nagios_host` resources

Default value: `true`

## Defined types

### nagios::nagios_service_http

Nagios HTTP service monitoring

#### Examples

##### monitoring a HTTP service (exports a resource)

```puppet
include nagios
nagios::nagios_service_http { "test.megacorp.com": }
```

#### Parameters

The following parameters are available in the `nagios::nagios_service_http` defined type.

##### `local_ip`

Data type: `Optional[String]`

Force using this IP address to test `site_name`, otherwise
use the default machine hostname

Default value: $nagios::local_ip

##### `site_name`

Data type: `String`

VHost name of HTTP site to test with `check_http`

Default value: $title

##### `url`

Data type: `String`

URL within site to test with `check_http`

Default value: ''

##### `service`

Data type: `String`

Nagios service to restart if needed

Default value: $nagios::service

##### `port`

Data type: `Integer`



Default value: 80

### nagios::nagios_service_tcp

Nagios TCP service monitoring

#### Examples

##### monitoring a TCP service (exports a resource)

```puppet
include nagios
nagios::nagios_service_tcp { "pgsql.megacorp.com":
  port => 5432,
}
```

#### Parameters

The following parameters are available in the `nagios::nagios_service_tcp` defined type.

##### `local_ip`

Data type: `Optional[String]`

Force using this IP address to test `site_name`, otherwise
use the default machine hostname

Default value: $nagios::local_ip

##### `site_name`

Data type: `String`

VHost name of HTTP site to test with `check_tcp`

Default value: $title

##### `port`

Data type: `Integer`

TCP port to monitor with `check tcp`

Default value: 80

##### `service`

Data type: `String`

Nagios service to restart if needed

Default value: $nagios::service

