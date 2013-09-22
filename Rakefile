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
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "memcached-manager"
  gem.homepage = "http://github.com/thiagofm/memcached-manager"
  gem.license = "MIT"
  gem.summary = "A sinatra memcached-manager that allows you to view status, flush/view keys and so on. Also easily pluggable to a Rails app."
  gem.description = "A sinatra memcached-manager that allows you to view status, flush/view keys and so on. Also easily pluggable to a Rails app."
  gem.email = "thiagown@gmail.com"
  gem.authors = ["Thiago Fernandes Massa", "Pedro Nicholas Souza"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

# Tests
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

require 'rspec/core/rake_task'
 
desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb"
end

task :default => [:features, :spec]

begin
  require 'jasmine'
  load 'jasmine/tasks/jasmine.rake'
rescue LoadError
  task :jasmine do
    abort "Jasmine is not available. In order to run jasmine, you must: (sudo) gem install jasmine"
  end
end
