#### Dependencies

* Ruby Version
  - 2.4
  - Most ruby versions should work.
  - If this is a fresh install of Ruby, then `$ gem install bundler`
* Rails Version
  - 5.1.1
  - Install rails with `$ gem install rails -v 5.1.1`
* Postgresql
  - [Postgresql](https://www.postgresql.org)
  - Install Postgresql

#### To get started:

* Start up Postgresql
* `$ git clone https://github.com/Robbie-Smith/api-example.git`
* `$ cd api-example`
* `$ bundle install`
* `$ rails db:create`
* `$ rails db:migrate`
* `$ rails s` to run the server locally
  - **The app will not run unless all of the required keys are present.**
    - **Required keys: can be found in config/initializers/figaro.rb**
    - See the notes section below.
* Using the browser of your choice visit localhost:3000/

#### Folders/Files of interest:

* Routes:
  - config/routes.rb
* Controllers:
  - app/controllers/
    - In app/controllers/oauth_controller.rb you can see a commented out example
      of implementing oauth using the gem [Oauth2-client](https://github.com/tiabas/oauth2-client)
* Models:
  - app/models/
* Services:
  - app/services/oauth_service.rb
    - This class is an example of implementing oauth using the gem [Faraday](https://github.com/lostisland/faraday)
  - app/services/api_service.rb
    - This class is an example of making calls to the TrainingPeaks API using the gem [Faraday](https://github.com/lostisland/faraday)
* Views:
  - app/views/api/new.html.erb
    - The form in this file, shows just one way to structure the data
      that is being passed into the params.

#### Notes:

* gem [Figaro](https://github.com/laserlemon/figaro)
  - This app uses Figaro to protect the environment variables.
  - For more information on how to use Figaro, reference the Figaro docs linked
    above.
* This app is just one example of how to implement oauth and make calls to the
  TrainingPeaks API. You should implement oauth and make calls to the TrainingPeaks API, in a
  way that makes sense for your app and follows the guidelines listed in the API
  docs.
