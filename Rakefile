require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the Publicious plugin.'
Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/*_test.rb'
end

require 'jeweler'
Jeweler::Tasks.new do |gemspec|
  gemspec.name = "publicious"
  gemspec.summary = "A Rails gem plugin for plugins to serve images, javascripts and stylesheets from thier own public directory"
  gemspec.description = "A Rails gem plugin for plugins to serve images, javascripts and stylesheets from thier own public directory"
  gemspec.email = "justin@indent.com.au"
  gemspec.homepage = "http://github.com/justinfrench/publicious"
  gemspec.authors = ["Justin French", "Daniel Neighman"]
end

desc 'Generate documentation for the Publicious plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Passive'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.textile')
  rdoc.rdoc_files.include('MIT-LICENSE')
  rdoc.rdoc_files.include('app/**/*.rb')
  rdoc.rdoc_files.include('test/*.rb')
  rdoc.rdoc_files.include('rails/init.rb')
end
