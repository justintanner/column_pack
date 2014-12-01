$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "column_pack/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "column_pack"
  s.version     = ColumnPack::VERSION
  s.authors     = ["Justin Tanner"]
  s.email       = ["justinwtanner@gmail.com"]
  s.summary     = "A rails view helper to arrange content into columns."
  s.description = "Uses a simple bin packing algorithm to arrange content as evenly as possible into columns."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.8"

  s.add_development_dependency "sqlite3"
end
