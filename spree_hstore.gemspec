# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_hstore'
  s.version     = '2.1.2'
  s.summary     = 'Filter products by their properties using hstore'
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'Willian van der Velde'
  s.email     = 'willian@reinaris.nl'
  s.homepage  = 'https://github.com/Willianvdv'

  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_controllers_with_callbacks'

  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.2'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.13'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end
