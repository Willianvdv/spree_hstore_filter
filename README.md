SpreeHstore
===========

[![Build Status](https://travis-ci.org/Willianvdv/spree_hstore_filter.png?branch=master)](https://travis-ci.org/Willianvdv/spree_hstore) [![Coverage Status](https://coveralls.io/repos/Willianvdv/spree_hstore_filter/badge.png?branch=master)](https://coveralls.io/r/Willianvdv/spree_hstore?branch=master)

Introduction goes here.

Installation
------------

Add spree_hstore to your Gemfile:

```ruby
gem 'spree_hstore'
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
DB=postgres bundle exec rake test_app
bundle exec rspec spec
```

If your postgres running on localhost:
```shell
bundle
DB=postgres DB_HOST=localhost bundle exec rake test_app
bundle exec rspec spec
```
