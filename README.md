Spree hstore filter
===

[![Build Status](https://travis-ci.org/Willianvdv/spree_hstore_filter.png?branch=master)](https://travis-ci.org/Willianvdv/spree_hstore) [![Coverage Status](https://coveralls.io/repos/Willianvdv/spree_hstore_filter/badge.png)](https://coveralls.io/r/Willianvdv/spree_hstore_filter)

Fast way to filter products by their properties. Per taxon you can define on what properties you want to filter on. This gem uses hstore so your Spree commerce shop **must** run on Postgres 8.4+.

Installation
------------

Add spree_hstore to your Gemfile:

```
gem 'spree_hstore', github: 'Willianvdv/spree_hstore_filter'
```

Install the migrations and migrate

```
$ bundle exec rake railties:install:migrations FROM=spree_hstore
$ bundle exec rake db:migrate
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```
bundle
DB=postgres bundle exec rake test_app
bundle exec rspec spec
```

If your Postgres is running on localhost:

```
bundle
DB=postgres DB_HOST=localhost bundle exec rake test_app
bundle exec rspec spec
```
