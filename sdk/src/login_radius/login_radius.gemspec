
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "login_radius/version"

Gem::Specification.new do |spec|
  spec.name          = "login_radius"
  spec.version       = LoginRadius::VERSION
  spec.authors       = ["LoginRadius"]
  spec.email         = ["developers@loginradius.com"]

  spec.summary       = %q{A Ruby wrapper for the LoginRadius API.}
  spec.homepage      = "https://www.loginradius.com"
  spec.license       = "MIT"


  # Specify which files should be added to the gem when it is released.
  spec.files         = %x(git ls-files -z).split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.2.26"
  spec.add_development_dependency "rake", "~> 13.0.3"
end
