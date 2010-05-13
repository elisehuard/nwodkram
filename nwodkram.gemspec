Gem::Specification.new do |s|
  s.name = 'nwodkram'
  s.version = '0.3'
  s.date = '2010-05-12'

  s.description = 'Convert html into markdown'
  s.summary = 'Convert html into markdown - this might be useful when going from a traditional blog to a more text-based blog.'

  s.authors = ['Elise Huard']
  s.email = 'nwodkram@elisehuard.be'
  s.homepage = 'http://github.com/elisehuard/nwodkram'

  s.files = %w[
              README.md
              lib/nwodkram_parser.rb
              lib/nwodkram.rb
              Rakefile
              nwodkram.gemspec
              spec/spec_helper.rb
              spec/spec.opts
              spec/rcov.opts
              spec/nwodkram_spec.rb
             ]
  s.test_files = s.files.select {|path| path =~ /^spec\/.*_spec.rb/ }
  s.add_dependency 'nokogiri', '>= 1.4.1'
  s.require_paths = %w[lib]
end
