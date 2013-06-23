# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'angular-tabs/version'

Gem::Specification.new do |spec|
  spec.name          = "angular-tabs"
  spec.version       = AngularTabs::VERSION
  spec.authors       = ["Samuel Mueller"]
  spec.email         = ["mueller.samu@gmail.com"]
  spec.description   = "Simple angular directive for declaring tabs."
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/ssmm/angular-tabs"
  spec.license       = "MIT"
  spec.files         = Dir["lib/**/*"] + Dir["app/**/*"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end