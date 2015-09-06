# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sakurraform/version'

Gem::Specification.new do |spec|
  spec.name          = "sakurraform"
  spec.version       = SakurraForm::VERSION
  spec.authors       = ["sawanoboly"]
  spec.email         = ["sawanoboriyu@higanworks.com"]
  spec.summary       = %q{Manage Infrastructure from Code with Sakura no Cloud}
  spec.description   = %q{Manage Infrastructure from Code with Sakura no Cloud}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "uuid"
  spec.add_dependency "aws-sdk", "< 2.0"
  spec.add_dependency "chamber"
  spec.add_dependency "ipaddress"
  spec.add_dependency "fog-sakuracloud"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
end
