# Scaffold

This is a basic Rails app set up for starting a web project from. It has a
simple, secure login system already created, with emails used as usernames.
It is set up to use Javascript rather than the Coffeescript default; if
you wish to use Coffeescript, add `gem 'coffee-rails'` in the Gemfile before
creating any scaffolding.


##To configure:

Edit `database.yml` to include the project name in database fields. Configure
with 
    $ rake db:create db:setup

When adding the models and controllers needed for your project's arrangement,
use

    $ rails g scaffold ModelName field1:type field2:type

Which will create the model, blank controller, migration, views, and tests.
