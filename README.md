SpreeHstore
===========

[![Build Status](https://travis-ci.org/Willianvdv/spree_hstore.png?branch=master)](https://travis-ci.org/Willianvdv/spree_hstore) [![Coverage Status](https://coveralls.io/repos/Willianvdv/spree_hstore/badge.png?branch=master)](https://coveralls.io/r/Willianvdv/spree_hstore?branch=master)

Introduction goes here.

Installation
------------

Add spree_hstore to your Gemfile:

```ruby
gem 'spree_hstore'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_hstore:install
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_hstore/factories'
```

Copyright (c) 2013 [name of extension creator], released under the New BSD License
