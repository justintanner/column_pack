# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'column_pack'
  spec.version       = '1.0.0'
  spec.authors       = ['Justin Tanner']
  spec.email         = ['justinwtanner@gmail.com']
  spec.summary       = %q{Organizes items evenly into columns.}
  spec.description   = %q{Orangizes items as evenly as possible into several columns.}

  spec.files         = Dir['lib/**/*']
  spec.require_path  = 'lib'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_dependency('rails', '>= 4.1.7')

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.1.0'
end
