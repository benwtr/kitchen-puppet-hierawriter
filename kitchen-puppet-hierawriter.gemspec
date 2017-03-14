# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kitchen_puppet_hierawriter/version'

Gem::Specification.new do |spec|
  spec.name          = 'kitchen-puppet-hierawriter'
  spec.version       = KitchenPuppetHierawriter::VERSION
  spec.authors       = ['benwtr']
  spec.email         = ['ben@g.megatron.org']

  spec.summary       = 'YAML generator addon for the puppet test-kitchen provisioner'
  spec.homepage      = 'https://github.com/benwtr/kitchen-puppet-hierawriter'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_dependency 'kitchen-puppet', '~>1.47'
end
