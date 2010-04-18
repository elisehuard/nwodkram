require "rubygems"


task :default => :spec

begin
  require 'spec/rake/spectask'
rescue LoadError
  desc "Run specs"
  task(:spec) { $stderr.puts '`gem install rspec` to run specs' }
else
  desc "Run specs"
  Spec::Rake::SpecTask.new do |t|
    t.spec_opts = ['--options', "\"#{File.dirname(__FILE__)}/spec/spec.opts\""]
    t.spec_files = FileList['spec/*_spec.rb'] 
  end

  desc "Run all specs in spec directory with RCov"
  Spec::Rake::SpecTask.new(:rcov) do |t|
    t.spec_opts = ['--options', "\"#{File.dirname(__FILE__)}/spec/spec.opts\""]
    t.spec_files = FileList['spec/*_spec.rb']
    t.rcov = true
    t.rcov_opts = lambda do
      IO.readlines(File.dirname(__FILE__) + "/spec/rcov.opts").map {|l| l.chomp.split " "}.flatten
    end
  end

end
