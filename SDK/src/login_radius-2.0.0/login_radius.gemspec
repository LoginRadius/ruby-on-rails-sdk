# -*- encoding: utf-8 -*-
require File.expand_path('../lib/login_radius/version', __FILE__)

Gem::Specification.new do |s|
  s.authors       = ["LoginRadius"]
  s.licenses      = ['MIT']
  s.email         = ["hello@loginradius.com"]
  s.description   = %q{Ruby wrapper for User Registration API}
  s.summary       = %q{Is a ruby wrapper for User Registration API}
  s.homepage      = "https://www.loginradius.com"

  s.files = Dir['lib/**/*']+Dir['LICENSE']+Dir['README.md']
  s.name          = "login_radius"
  s.require_paths = ["lib"]
  s.version       = LoginRadiusRaas::VERSION
	
end