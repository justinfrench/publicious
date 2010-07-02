require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the Publicious plugin.'
Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/*_test.rb'
end

desc 'Generate documentation for the Publicious plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Publicious'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.textile')
  rdoc.rdoc_files.include('MIT-LICENSE')
  rdoc.rdoc_files.include('app/**/*.rb')
  rdoc.rdoc_files.include('test/*.rb')
  rdoc.rdoc_files.include('rails/init.rb')
end
