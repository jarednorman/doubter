# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'doubter/version'

Gem::Specification.new do |spec|
  spec.name          = "doubter"
  spec.version       = Doubter::VERSION
  spec.authors       = ["Jared Norman"]
  spec.email         = ["jared@creepywizard.com"]

  spec.summary       = %q{A really awful router}
  spec.description   = %q{A really awful router}
  spec.homepage      = "https://github.com/jarednorman/doubter"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
