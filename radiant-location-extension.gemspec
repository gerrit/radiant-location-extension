# -*- encoding: utf-8 -*-
require File.expand_path('../lib/radiant-location-extension/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Adam van den Hoven']
  gem.email         = ['adam.vandenhoven@gmail.com']
  gem.description   = %q{Location is a Radiant Extension that will allow you to create relatively robust list of locations (stores, churches, etc.).}
  gem.summary       = %q{Adds a location database to Radiant CMS}
  gem.homepage      = 'http://starkravingcoder.blogspot.com'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'radiant-location-extension'
  gem.require_paths = ['lib']
  gem.version       = RadiantLocationExtension::VERSION
  
  gem.add_dependency 'radiant', '>=0.9'
   # Radiant depends on rDoc anyway, but just to be sure
  gem.add_development_dependency 'rdoc', '>=2.4'
end
