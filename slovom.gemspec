# -*- encoding: utf-8 -*-
require File.expand_path('../lib/slovom/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Svilen Vassilev"]
  gem.email         = ["svilen@rubystudio.net"]
  gem.description   = %q{Converts decimal currency numbers into words in Bulgarian language. For use in financial applications, documents, etc.}
  gem.summary       = %q{Converts decimal currency numbers into words in Bulgarian language}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "slovom"
  gem.require_paths = ["lib"]
  gem.version       = Slovom::VERSION

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rake"
end
