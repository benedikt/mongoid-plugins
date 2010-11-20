require 'rspec/core/rake_task'
require 'hanna/rdoctask'
require 'bundler'
Bundler::GemHelper.install_tasks

spec = Gem::Specification.load('mongoid-plugins.gemspec')

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title = '#{spec.name} #{spec.version}'
  rdoc.options += spec.rdoc_options
  rdoc.rdoc_files.include(spec.extra_rdoc_files)
  rdoc.rdoc_files.include('lib/**/*.rb')
end
