# -*- encoding: utf-8 -*-
require File.expand_path('../lib/login_radius/version', __FILE__)
require 'rake'

Gem::Specification.new do |gem|
  gem.authors       = ["LoginRadius"]
  gem.licenses      = ['MIT']
  gem.email         = ["hello@loginradius.com"]
  gem.description   = "Ruby wrapper for LoginRadius API v2"
  gem.summary       = "Is a ruby wrapper for LoginRadius API v2"
  gem.homepage      = "https://www.loginradius.com"

  gem.files         = FileList['lib/*.rb', 'lib/login_radius/*.rb']
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "loginradius"
  gem.require_paths = ["lib"]
  gem.version       = LoginRadius::VERSION
  
  gem.add_dependency 'em-http-request'
  gem.add_dependency 'em-synchrony'
	
end
