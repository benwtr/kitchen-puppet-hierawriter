# Kitchen Puppet Hierawriter

## DEPRECATION NOTICE

**This functionality has now been integrated upstream into kitchen-puppet
(https://github.com/neillturner/kitchen-puppet/commit/f858e0918a2c8c193b2e3697d7f25fa0507103b7).
Please use it instead. The gem will be yanked from Rubygems soon.**


## Description

Adds (hiera) YAML file generation
to [kitchen-puppet](https://github.com/neillturner/kitchen-puppet),
the [puppet](https://puppetlabs.com) [test-kitchen](https://kitchen.ci)
provisioner.

Allows creation of arbitrary YAML files in the target instance's `hieradata/`
dir in test-kitchen configuration (eg `kitchen.yml`). Like setting chef
attributes in `kitchen.yml`, except for Hiera YAML files.

Currently only the `puppet_apply` provider from kitchen-puppet is supported.


## Installation

Add this line to your puppet repo or module's Gemfile:

```ruby
gem 'kitchen-puppet-hierawriter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kitchen-puppet-hierawriter


## Usage

See kitchen-puppet's documentation https://github.com/neillturner/kitchen-puppet

Once you have **kitchen-puppet** working, change the `puppet_apply` provisioner
to `puppet_hierawriter_apply` and set `hiera_writer_files` in `kitchen.yml`

```
---
driver:
  name: vagrant

provisioner:
  #name: puppet_apply
  name: puppet_hierawriter_apply
  manifests_path: /repository/puppet_repo/manifests
  modules_path: /repository/puppet_repo/modules-mycompany
  hiera_data_path: /repository/puppet_repo/hieradata
  hiera_writer_files:
    - datacenter/vagrant.yaml:
      logstash_servers: []
      hosts:
        10.1.2.3:
        - puppet
        - puppetdb

platforms:
- name: nocm_ubuntu-12.04
  driver_plugin: vagrant
  driver_config:
    box: nocm_ubuntu-12.04
    box_url: http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210-nocm.box

suites:
 - name: default
```

The above configuration will result in the creation of a file on the guest named
`${hieradata}/datacenter/vagrant.yaml` containing:

```
---
logstash_servers: []
  hosts:
    10.1.2.3:
    - puppet
    - puppetdb
```

It will overwrite any existing Hiera YAML files with the same name (on the
guest), not merge.


## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/benwtr/kitchen-puppet-hierawriter.


## License

The gem is available as open source under the terms of
the [MIT License](http://opensource.org/licenses/MIT).

