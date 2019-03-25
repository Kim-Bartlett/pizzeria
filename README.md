# README

## Requirements:
ruby 2.6.1
posgres 8.4+

## Setup
```
bundle install
```

Set up your postgres user & database
```
  database: pizzeria-api_development
  username: pizzeria
  password: pizzeria
```

```
rake db:create db:migrate db:seed
```

```
rails s
```

Access api at [localhost:3000/api-docs]

## TO DO's if I had more time
* Add admin/pizzeria staff account model
* Authentication for cutomers & admin (probably using Devise)
* Admin Panel API calls for creating/editing/deleting toppings/types
* Suggest pizzas for user based on history
* Add a default address to customers / utilize customers at all really (I had intentions to do this)
* Search orders with pgsearch gem

* DRY up price formatting with helper/concern
* More test coverage --  specifically a lot of model defs are missing tests, controller tests are sad & check response bodies in integration tests.
* Deploy to heroku (might work on later this week)


