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
  gem.name = "locale_gen"
  gem.homepage = "http://github.com/aproxacs/locale_gen"
  gem.license = "MIT"
  gem.summary = %Q{Generates locale files from google spreadsheet document.}
  gem.description = %Q{}
  gem.email = "aproxacs.gmail.com"
  gem.authors = ["aproxacs"]
  gem.executables = ["locale_gen"]
  gem.files = [
    "Rakefile",
    "README.rdoc",
    "VERSION",
    "bin/locale_gen",
    "config/config.exmample.yml",
    "lib/locale_gen.rb",
    "lib/locale_gen/**/*.rb"
  ]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

