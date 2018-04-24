# Bookmark Manager

### Prerequisites

The PostgreSQL database management system should be installed on your system.

### Getting started

##### To get started with Bookmark Manager:
 
 ```
 - git clone https://github.com/meta-morpho-sys/new_bookmark_manager
 - cd new_bookmark_manager
 - bundle install
 - rake create_databases
 - rspec
 ```
This will give you the application, and set up two databases: `new_bookmark_manager` for the development environment, 
and `new_bookmark_manager_test` for the test environment.
 
##### Security:
 ```
 - specify your session secret key (20 byte) as environmental variable or you can use the fail-safe option (SecureRandom secret) provided within the app
 ```


#### What you can do with this app.

 ```
 You can see a list of bookmarks on the homepage
 Add a bookmark to your Bookmark Manager
 Update and remove your bookmarks
 Leave and view comments or brief notes
 Create tags and view your bookmarks by tag
 ```
 
