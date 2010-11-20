Gem::Specification.new do |s|
  s.name        = 'mongoid-plugins'
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = 'Benedikt Deicke'
  s.email       = 'benedikt@synatic.net'
  s.homepage    = 'http://rubygems.org/gems/mongoid-plugins'
  s.summary     = 'Easily add and configure plugins for Mongoid'
  s.description = 'Easily add and configure plugins for Mongoid'

  s.has_rdoc      = true
  s.rdoc_options  = ['--main', 'README.rdoc', '--charset=UTF-8']
  s.extra_rdoc_files = ['README.rdoc', 'LICENSE']

  s.files         = Dir.glob('{lib,spec}/**/*') + %w(LICENSE README.rdoc Rakefile Gemfile Gemfile.lock .rspec)

  s.add_runtime_dependency('mongoid', ['>= 2.0.0.beta.20'])
  s.add_development_dependency('rspec', ['~> 2.0'])
  s.add_development_dependency('autotest', ['>= 4.3.2'])
  s.add_development_dependency('hanna', ['>= 0.1.12'])
end
