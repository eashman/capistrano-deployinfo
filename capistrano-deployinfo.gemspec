# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "capistrano-deployinfo"
  spec.version       = '1.0.10'
  spec.authors       = ["Bob Breznak"]
  spec.email         = ["bob.breznak@gmail.com"]
  spec.description   = %q{Capistrano tasks that write information about deploy into a project for quick referenceCapistrano tasks that write information about deploy into a project for quick reference.}
  spec.summary       = %q{Cap tasks to generate static deploy info files.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  
  spec.add_dependency 'capistrano', '~> 3.1'
end
