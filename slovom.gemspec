# -*- encoding: utf-8 -*-
require File.expand_path('../lib/slovom/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Svilen Vassilev"]
  gem.email         = ["svilen@rubystudio.net"]
  gem.description   = %q{Converts decimal currency numbers into text in Bulgarian language. For use in financial applications, documents, and all other instances requiring currency verbalization.}
  gem.summary       = %q{Converts decimal currency numbers into text in Bulgarian language}
  gem.homepage      = "https://github.com/tarakanbg/slovom"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "slovom"
  gem.require_paths = ["lib"]
  gem.version       = Slovom::VERSION

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rake"
end
