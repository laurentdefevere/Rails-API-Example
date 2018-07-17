#### Wiki
* [Documentation](https://github.com/TrainingPeaks/Rails-API-Example/wiki)

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
* `$ git clone https://github.com/TrainingPeaks/Rails-API-Example.git`
* `$ cd api-example`
* `$ bundle install`
* `$ rails db:create`
* `$ rails db:migrate`
* `$ rails s` to run the server locally
  - Port 3000 is the default port.
  - **The app will not run unless all of the required keys are present.**
    - **Required keys: can be found in config/initializers/figaro.rb**
    - See the notes section below.
  - **Environment Variables**
    - All the environment variables live in config/application.yml
* Using the browser of your choice visit localhost:3000/

#### Notes:

* gem [Figaro](https://github.com/laserlemon/figaro)
  - This app uses Figaro to protect the environment variables.
  - For more information on how to use Figaro, reference the Figaro docs linked
    above.
* This app is just one example of how to implement oauth and make calls to the
  TrainingPeaks API. You should implement oauth and make calls to the TrainingPeaks API, in a
  way that makes sense for your app and follows the guidelines listed in the API
  docs.
