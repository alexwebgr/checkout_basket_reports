# Checkout basket

## The situation 
You’re working on an online shopping platform. The sales team wants to know which items were added to a basket, but removed before checkout.
We will use this data later for targeted discounts.

## The task 
Build a shopping basket that helps you get this data.

## The solution
I have created an API-only rails app that resembles a shopping basket. It follows a simple flow.
For the links below to work make sure that the documentation has been [generated](#documentation).

### User flow
* user visits the [home page](http://localhost:3000/apipie/1.0/shop/list_products.html) where they find a list products and at that time 
a checkout session is also created.

* user adds products to the basket by calling the [add_product](http://localhost:3000/apipie/1.0/basket/add_product.html)
  * a new model in checkout products is created which contains the checkout session id and the product id. This is where we also keep the removed status
  which is a timestamp field called `removed_at` and from that we assume that if the field is populated the product is marked as removed
* user decides to remove a product from the basket (checkout_products) then the [remove_product](http://localhost:3000/apipie/1.0/basket/remove_product.html)
endpoint is called marking it as removed by populating the `removed_at` field with the current time. 
* after the user has finished shopping they arrive at the [checkout](http://localhost:3000/apipie/1.0/basket/list.html) where they can view all the products 
they have added, excluding the ones they removed, to the basket during this session.
* Once they 'pay' the session is complete and the [checkout_complete](http://localhost:3000/apipie/1.0/basket/checkout_complete.html) endpoint is called, 
making it impossible to add or remove any more products from that session.

### Sales team user flow
The sales team has a list of reports they can use in order to retrieve the customer shopping data and make the right decisions
* [count_removed_products](http://localhost:3000/apipie/1.0/reports/count_removed_products.html) will return a list of products that were removed starting 
from the most expensive one
```json
[
  {
    "amount_removed": 2,
    "product_name": "product_37",
    "product_price": 370
  },
  {
    "amount_removed": 5,
    "product_name": "product_36",
    "product_price": 360
  },
  {
    "amount_removed": 5,
    "product_name": "product_35",
    "product_price": 350
  }
]
```

* [products_grouped_by_session](http://localhost:3000/apipie/1.0/reports/products_grouped_by_session.html) will return a list of all products grouped by session
by passing the optional param `removed_status` they can filter the list to see `all`, `removed` or `not_removed` each list of products is sorted by most expensive
```json
{
  "zNZb3sFFivA98MkYwXsEQw": {
    "token": "zNZb3sFFivA98MkYwXsEQw",
    "started_at": "2021-10-14T14:26:41.903Z",
    "ended_at": "2021-10-14T14:26:42.958Z",
    "products": [
      {
        "product_name": "product_37",
        "product_price": 370,
        "added_at": "2021-10-14T14:26:42.858Z",
        "removed_at": "2021-09-07T14:26:42.857Z"
      }
    ]
  }
}
```
* [products](http://localhost:3000/apipie/1.0/reports/products.html) will return a list of all products
  by passing the optional param `removed_status` they can filter the list to see `all`, `removed` or `not_removed`  starting
  from the most expensive one 
```json
[
  {
    "product_name": "product_39",
    "product_price": 390,
    "added_at": "2021-10-14T14:05:33.369Z",
    "removed_at": null
  }
]
```

## Local installation
In order to run the app locally you will need ruby 3.0.0 installed preferably via a version manager like rbenv. also postgres as a db with the user credentials
found the in the `/config/database.yml` file. In a production environment the credentials are either encrypted by using the rails built-in encrypted credentials
feature or by using ENV variables managed with a gem like dotenv and can be found in an .env file. Personally i prefer using encrypted credentials 
as it allows you to keep them under version and the only thing you need to worry about is having the key in place either stored in a `.key` file or as 
a ENV[RAILS_MASTER_KEY] variable. A visual schema for the database can be found under `/schema.xml` 

Once that is sorted out we can run the following commands to get up and running
```shell
bundle install
rails db:schema:load
rails s
```

## Test suite
For testing Rspec was used coupled with factory_bot for test setups and simplecov for measuring the code test coverage which is currently at 100%.

To run the tests we need to run the following commands
```shell
rspec
```
## <a id="documentation"></a>API documentation generation ###
In order to generate the documentation for the endpoints the [apipie](https://github.com/Apipie/apipie-rails) gem was used which generates documentation 
by parsing the tests but also the routes.rb file. In order to generate the docs locally run ` APIPIE_RECORD=examples rspec` and then navigate to [http://localhost:3000/apipie](http://localhost:3000/apipie)

### Swagger
apipie can also generate swagger compatible documentation by running `rake apipie:static_swagger_json` which can be viewed by navigating to `/doc/swagger/index.html`
