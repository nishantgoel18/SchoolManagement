# README
The app is a simple school management system where admin can create schools and assign school admins to it. School admins can create courses, batches in schools and also take actions on student's enrollments request for a course

# Ruby version
Ruby version 2.7.8 is required to run the application. It can be installed either using rbenv or rvm

# System dependencies
Sqlite3 is used as database adapter so appropriate brew package for mac os or apt package for ubuntu is required to run app with sqlite3 database. Node JS version 19.3.0 is used for installing yarn packages.

# Installing Gems & yarn packages
To install the gems in application run following commands
* gem install bundler
* bundle install
* npm install --global yarn
* yarn install

# Database creation
To create the database, run the following command
* rails db:create

# Database initialization
To initialize the database run the following commands
* rails db:migrate
* rails db:seed

# How to run the application in development env
To start the application in development environment run following commands
* rails s

After this puma server in console should start running in port 3000. Now in web browser app can be accessed at URL: http://localhost:3000

# How to run the test suite
To run the test suite run the following commands
* RAILS_ENV=test rails db:migrate
* rspec
