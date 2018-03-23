# Bookmark Manager

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
 
 
