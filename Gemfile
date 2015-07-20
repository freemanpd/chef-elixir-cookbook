source 'https://rubygems.org'

gem 'rake'

group :test do
  gem 'json'
  gem 'foodcritic'
  gem 'chefspec'

  # Workaround: There is a ChefSpec regression when integrating with Chef 11.10+
  gem 'chef', '~> 11.8.0'
end
