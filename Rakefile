# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "shrinkwrap"
  gem.homepage = "http://github.com/jayofdoom/shrinkwrap"
  gem.license = "Apache 2.0"
  gem.summary = %Q{Shrinkwraps code for quick and safe deployment}
  gem.description = %Q{
    Shrinkwraps code for quick and safe deployment. Initial release will tar
    code, encrypt and sign it, then upload it to a CDN. This also contains 
    deployment tools for unwrapping and deploying these packages
  }
  gem.email = "jay@jvf.cc"
  gem.authors = ["Jay Faulkner"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['test'].execute
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "shrinkwrap #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'rubocop/rake_task'

Rubocop::RakeTask.new
