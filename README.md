# Bookmark Manager

##### App developed during [Makers Academy](https://www.makersacademy.com/) course for the purpose of studying of the Sinatra framework, Databases and ORM.

With this is an app you can store and display all links that you want to keep within easy reach. 

Add as many bookmarks as you wish, update them, leave comments and assign tags, 
 and when you no longer need your bookmarks, you can easily remove them.


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

 
 
