[![Build Status](https://travis-ci.org/GeoffWilliams/puppet-nagios.svg?branch=master)](https://travis-ci.org/GeoffWilliams/puppet-nagios)

# nagios

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with nagios](#setup)
    * [What nagios affects](#what-nagios-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with nagios](#beginning-with-nagios)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Installs and configures nagios monitoring system.

## Setup

### What nagios affects
* Installs Apache HTTPd
* Makes Nagios avaiable at `/nagios`
* Password protects the `/nagios` directory

### Setup Requirements

Requires a functioning web server created with the [puppetlabs-apache module](https://forge.puppet.com/puppetlabs/apache).  One will be created for you if it doesn't already exit


## Usage

```puppet
include nagios
```

Install nagios with the default settings. The class is parameterised to allow customisation. See source code for details.

```puppet
class { "nagios":
  $collect          = true,
  $monitor_tag      = "__MONITOR__",
  $apache_conf_dir  = $nagios::params::apache_conf_dir,
  $htpasswd         = $nagios::params::htpasswd,
  $password         = "changeme",
  $realm            = "/nagios",
}
```

## Reference

* `nagios` - Install and configure Nagios and Apache HTTPd
* `nagios::params` - Platform specific settings

## Limitations

RHEL/centos only for the moment

## Development

PRs accepted

## Testing
This module supports testing using [PDQTest](https://github.com/GeoffWilliams/pdqtest).

Test can be executed with:

```
bundle install
bundle exec pdqtest all
```


See `.travis.yml` for a working CI example

## Contributors

* Brett Gray
* Geoff Williams
