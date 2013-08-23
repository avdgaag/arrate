# -*- encoding: utf-8 -*-
require File.expand_path('../lib/arrate/version', __FILE__)

Gem::Specification.new do |s|
  # Metadata
  s.name        = 'arrate'
  s.version     = Arrate::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Arjan van der Gaag']
  s.email       = %q{arjan@arjanvandergaag.nl}
  s.description = %q{Custom templates for Rails generators}
  s.homepage    = %q{http://avdgaag.github.com/arrate}
  s.summary     = <<-EOS
A set of templates to override default Rails generator templates that better
suit my preferences. This assumes you want to use gems like simple_form, rspec,
factory_girl and haml.
EOS

  # Files
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # Rdoc
  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = [
     'LICENSE',
     'README.md',
     'HISTORY.md'
  ]

  # Dependencies
  s.add_development_dependency 'kramdown'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
  s.add_dependency 'haml-rails'
  s.add_dependency 'rspec-rails'
  s.add_dependency 'factory_girl_rails'
  s.add_dependency 'simple_form'
end
