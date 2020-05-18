
# COVID Help

[![Build Status](https://travis-ci.org/Williams-Dan/covidhelp.svg?branch=master)](https://travis-ci.org/Williams-Dan/covidhelp)

This project is for the traveltek covid-19 hackathone, the idea is to build a platform where people in need can post what they need and be matched up with volenteers who can help out.


## Prerequisites

What things you need to install and setup to get started:

### Ruby:

**Windows:** [RubyInstaller](https://rubyinstaller.org/2020/01/05/rubyinstaller-2.7.0-1-released.html)

**Linux:** 

* `git clone https://github.com/rbenv/rbenv.git ~/.rbenv`
* `echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc`
* `echo 'eval "$(rbenv init -)"' >> ~/.bashrc`
* `git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build`
* `echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc`
* `git clone https://github.com/rbenv/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars`
* `rbenv install 2.7.0`
* `rbenv global 2.7.0`

### MariaDb:

Refere to the install documentation for your OS [MariaDB](https://mariadb.com/kb/en/getting-installing-and-upgrading-mariadb/)

### Local Database:

**NOTE:** these steps are to setup a database and user localy and do not follow security standards for setting up a live database

* Connect to mariadb as root `mysql -u root -p`
* Create a user for the app `create user covid_help_app@localhost identified by 'password1!';` 
* Create a database `create database covidhelp;`
* Grant your user priviages to the database `grant all privileges on covidhelp.* to 'covid_help_app'@localhost;`

### Dotenv:  
dotenv is used for keys and secrets.
The following are required:
- SESSION_SECRET (`echo "SESSION_SECRET=$(openssl rand -base64 32)" > .env`)


## Rake Tasks

Task | Description
------------ | -------------
db:create_migration | Create a migration (parameters: NAME, VERSION)
db:migrate |  Migrate the database schema to the most recent migration
db:version | Shows the current schema version number
install | Simple wrapper for `bundle install`
lint | Runs the linter over the code base and tries to fix what it can [Rubocop](https://docs.rubocop.org/en/stable/)
run | Runs the app locally
test | Runs the rspec tests
deploy | Deploys to given host address, HOST should be set and the ssh key should be setup on deploying machine e.g `rake deploy HOST=<address>`

To see all tasks you can just run `rake -T`


## Running the tests

At the moment there is a rake task for running the automated test just run `rake test`

## Deployment

There is a rake task for running the deployment, but at the moment it is not completed and doesn't yet work `rake deploy`

## Built With

* [Sinatra](http://sinatrarb.com/intro.html) - The web framework used
* [Active Record](https://www.rubydoc.info/gems/sinatra-activerecord/2.0.18) - The ORM and schema migrator used
* [Rake](https://ruby.github.io/rake/) - The build tool used
* [RSpec](https://rspec.info/documentation/) - The testing framework used

## Contributing

This section for information on how to contribute

### Forking and cloning the repo

* Click the "Fork" button and wait for the fork to finsih;
* On your fork of the reposity click the "Clone or download" button and copy the https url (If you prefer to use ssh find instructions [here](https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh))
* In your terminal cd to the directory you would like to clone into and run `git clone <url you just copied>`

### Choosing something to work on

Simply go to our issues page, pick something, assign it to yourself and start working. Alternativly feel free to add your own issues with as much detail as possible

### Making a change 

When it comes to making changes what you change and why will obviously depend on the ticket your working on, but regardless please make sure to add tests for the changes you make and run `rake lint` and fix any errors before submitting a PR.

#### Adding a new controller

* Add a new file under app/controllers called: "modelname_controller.rb" (Where modelname is the name of the model the controller relates to)
* In the new file create a class called "ModelNameController" (Again change ModelName) and make sure it inherets ApplicationController
* In the new class add your sinatra route (You can read about there [here](http://sinatrarb.com/intro.html))
* Add `use ModelNameController` in config.ru before `run ApplicationController`

Your controller should look something like this:

```ruby
class ModelNameController < ApplicationController

	# Routes here

end
```

#### Adding a new model

* Add a new file under app/models called: "model_name.rb" (Where model_name is the name of the model)
* In the new file create a class called ModelName (Again change ModelName) and make sure it inherets "ActiveRecord::Base"
* In the new class add your active record associations and other configs (Refere to the documentation for more details)

Your model should look something like this:

```ruby
class ModelName < ActiveRecord::Base
	# ActiveRecord configs here
end
```

Now you will need to add a migration to include your new model to the schema:

* Run `rake db:create_migration NAME=create_model_names` (don't forget to replace "model_names")
* This will create a migration file in db/migrate edit that file to include the columns you want in your new table
* Run `rake db:migrate` to run the new migration and make sure it runs correctly as expected

#### Adding a new view

* Create a new file in 'app/views/<\model>s/' called '<\your_new_view_name>.erb'
* In your new file add whatever html and erb tags you need to build your view (Your can read more on erb [here](https://docs.ruby-lang.org/en/2.7.0/ERB.html))

#### Making a change to the schema

To change the schema you will need to add a new migration:

* Run `rake db:create_migration NAME=<what you want to change>` 
* This will create a migration file in db/migrate edit that file to include the changes you want
* Run `rake db:migrate` to run the new migration and make sure it runs correctly as expected

### Opening a pull request

You can read how to open a PR from a fork [here](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request-from-a-fork)

### Rebase

When someone makes a change to the upstream repo you will need to sync your for with the upstream, we can do this by rebasing.
First you will need to add the upstream as a remote, you only need to do this part once, run `git remote add upstream https://github.com/Williams-Dan/covidhelp.git`

from here to rebase do:
* `git fetch upstream`
* `git checkout master`
* `git rebase upstream/master`
* `git push -f origin master`

The master branch on your fork should now be the same as the master branch on the upstream
