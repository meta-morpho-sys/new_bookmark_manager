# Bookmark Manager

##### App developed during [Makers Academy](https://www.makersacademy.com/) course for the purpose of studying the Sinatra framework, Databases and ORM. The focus on this project was build from scratch an ORM tool with the aid of SQL and Ruby to store data in a database, convert it into objects and use it within the app.

With app you can store and display all links that you want to keep within easy reach. 
You can as many bookmarks as you wish, update them, leave comments and assign tags, 
 and when you no longer need your bookmarks, you can easily remove them.

### Technologies used
App:
- [Sinatra](https://github.com/sinatra/sinatra) - Quick tool for creating web applications
- [PG](https://deveiate.org/code/pg/) - The Ruby PostgreSQL Driver
- [BCrypt](https://rubygems.org/gems/bcrypt/versions/3.1.11) - Security algorithm for hashing passwords
- [Rake](https://github.com/ruby/rake) - task management and build automation tool

Testing:
- [RSpec](https://github.com/rspec/rspec) - Behaviour Driven Development for Ruby
- [Capybara](https://github.com/teamcapybara/capybara/blob/3.0_stable/README.md) - Simulator of how a user interacts with the app.


### Prerequisites

The PostgreSQL database management system should be installed on your system.

### Getting started:

##### To get started with Bookmark Manager:
 
 ```
 $ git clone https://github.com/meta-morpho-sys/new_bookmark_manager
 $ cd new_bookmark_manager
 $ bundle install
 $ rake create_databases
 $ rspec
 ```

This will give you the application, and set up two databases: `new_bookmark_manager` for the development environment, 
and `new_bookmark_manager_test` for the test environment.
 
##### To launch the app in the browser:

From the command line `cd` into the app's directory and type the `rackup` command.

##### Security
Specify your session secret key as the environmental variable SESSION_SECRET.
If you don't specify this, the app will generate it's own 20 character SecureRandom secret.

 
 
