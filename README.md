### Instructions to set-up the example app
#### Dependencies

* Ruby Version
  - 2.4
* Rails Version
  - 5.1.1
* Postgresql
  - [Postgresql](https://www.postgresql.org)

To get started:

* Start up postgresql
* `git clone https://github.com/Robbie-Smith/api-example.git`
* `cd api-example`
* `bundle install`
* `rails db:create`
* `rails db:migrate`

Notes:

* [Figaro gem](https://github.com/laserlemon/figaro)
  * This app uses the gem to protect the environment variables
  * The app will not run unless all of the required keys are present.
    - Required keys: can be found in config/initializers/figaro.rb
  * For more information on how to use figaro, reference the figaro docs linked
    above.

