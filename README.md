# Bookmark Manager

### Prerequisites

The PostgreSQL database management system should be installed on your system.

### Getting started

+To get started with Bookmark Manager:
 
 ```
 git clone https://github.com/meta-morpho-sys/new_bookmark_manager
 cd new_bookmark_manager
 bundle install
 rake create_databases
 rspec
 ```

This will give you the application, and set up two databases: `new_bookmark_manager` for the development environment, and `new_bookmark_manager_test` for the test environment.

#### Domain model for the first user story

`As a time-pressed user
So that I can quickly go to web sites I regularly visit
I would like to see a list of links on the homepage`

     ┌──────────┐              ┌────┐
     │Controller│              │Link│
     └────┬─────┘              └─┬──┘
          │       all links      │   
          │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ >|   
          │                      │   
          │ [collection of links]│   
          │<─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─|   


#### Second user story

`As a user
 So I can store bookmark data for later retrieval
 I want to add a link to Bookmark Manager`
 
 
