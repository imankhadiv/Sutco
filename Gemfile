source 'http://rubygems.org'

gem 'airbrake'

gem 'rails', '~> 4.0.1'
gem 'haml-rails'
gem 'simple_form'

gem 'activerecord-session_store', github: 'rails/activerecord-session_store'

gem 'pg'

gem 'devise'
gem 'cancan'
# gem 'devise_cas_authenticatable'  # CAS support for devise   [https://github.com/nbudin/devise_cas_authenticatable]
# gem 'devise_ldap_authenticatable' # LDAP support for devise  [https://github.com/cschiewek/devise_ldap_authenticatable]

gem 'will_paginate'
gem 'draper'

gem "watu_table_builder", :require => "table_builder"
gem 'event-calendar', :require => 'event_calendar'
gem "actionpack"
gem "activesupport"
# gem 'ransack'             # Searching and sorting
# gem 'cocoon'              # Nice gem providing javascript and helper methods for adding/removing records in nested-forms [https://github.com/nathanvda/cocoon]

# https://github.com/lwe/simple_enum            # Nice enum gem
# https://github.com/pluginaweek/state_machine  # State machine implementation

gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'            # Compresses javascript for faster load time
 
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'bootstrap-sass', github: 'thomas-mcdonald/bootstrap-sass'      # Twitter bootstrap in sass form
gem 'font-awesome-rails'  # Bootstrap's icons rendered as a font

gem 'webshims-rails'

group :development, :test do
  gem 'rspec-rails'
  gem 'debugger'
  gem 'pry-rails'
end

group :development do
  gem 'thin'                # Use thin instead of webrick in dev as it's a bit faster and less annoying 
  gem 'letter_opener'       # Opens emails in the browser in dev
  
  # Capistrano for deployment
  gem 'capistrano', '~> 2.15'
  gem 'capistrano-ext'  
  
  gem 'rvm-capistrano'
  
  gem 'annotate'            # Annotates your models for you based on db schema (bundle exec annotate)
  
  # http://rails-erd.rubyforge.org/   # Entity Relationship Diagram generation
  
  ## GUARD -- used to automatically run commands
  # gem 'guard'
  # gem 'rb-fsevent', '~> 0.9.1'
  # gem 'growl'
  # gem 'guard-rspec'
  # gem 'guard-yard'
  # gem 'redcarpet' 
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'launchy'             # Used for save_and_open_page
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'    # The use of 'shoulda' and 'shoulda-context' will break testing in Ruby 1.9.3, so 'shoulda-matchers' instead
  
  gem 'simplecov'           # Code test coverage
end
