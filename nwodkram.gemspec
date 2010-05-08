Gem::Specification.new do |s|
  s.name = 'nwodkram'
  s.version = '0.2'
  s.date = '2010-05-01'

  s.description = 'Convert html into markdown'
  s.summary = 'Convert html into markdown'

  s.authors = ['Elise Huard']
  s.email = 'nwodkram@elisehuard.be'

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
