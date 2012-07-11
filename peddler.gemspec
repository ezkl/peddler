# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'peddler/version'

Gem::Specification.new do |s|
  s.name        = 'peddler'
  s.version     = Peddler::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Hakan Ensari']
  s.email       = ['hakan.ensari@papercavalier.com']
  s.homepage    = 'http://github.com/hakanensari/peddler'
  s.summary     = %q{An MWS wrapper}
  s.description = %q{A wrapper to the Amazon Marketplace Web Service (MWS) API}

  s.add_dependency             'jeff', '~> 0.3.2'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'vcr'

  s.files         = Dir.glob('lib/**/*') + %w(LICENSE README.md)
  s.test_files    = Dir.glob('spec/**/*')
  s.require_paths = ['lib']
end
