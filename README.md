
# COVID Help

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
deploy | TO BE IMPLEMENTED

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

TODO

