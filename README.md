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
     ┌────┴─────┐              ┌─┴──┐
     │Controller│              │Link│
     └──────────┘              └────┘
