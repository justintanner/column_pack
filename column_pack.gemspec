# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'column_pack'
  spec.version       = '1.0.0'
  spec.authors       = ['Justin Tanner']
  spec.email        = ['justinwtanner@gmail.com']
  spec.summary      = 'Organizes items evenly into columns.'
  spec.description  = 'Orangizes items as evenly as possible into several columns.'
  spec.files        = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  spec.require_path = 'lib'
  spec.test_files   = Dir["test/**/*"]

  spec.add_dependency 'rails', '>= 4.1.7'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
