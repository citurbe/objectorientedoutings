# Outings
***
## Summary
### - We're creating a social app
### - Enables members of a community to form groups for outings
### - Expected use cases include lunches and happy hours
***
## ORM
### - Organizations
| ID |    Name  | Admin |
| -- |:--------:| -----:|
| 1  |  Flatiron|   37  |
| 2  |  Google  |   42  |
| 3  |  Facebook|   56  |
### - Plans
| ID | Location  | Organizer | Datetime
| -- |:--------:| ----------:|  -----:|
| 1  |  Chipotle|     37     |    Jan 3rd  |
| 2  |  Google  |     42     |
| 3  |  Facebook|     56     |
### - Users
| ID | Name     |    Email    | Phone # | Opt IM
| -- |:--------:|:-----------:|:-------:|:------:|
| 1  |  John Travolta | pg@yahoo.com | 1800GOTMILK | Slack_user
### - Outings
| ID | Plan_id | User_id
| -- |:--------:|:--------:|
| 1  |  12      | 34
#
### - Reviews
| ID | User_id  | Location_id | Score |   Comment
| -- |:--------:| ----------:|  -----:|
| 1  |    32    |   4  |  6 |        Falafel sucks AND racist  |
| 2  |  Google  |   42  |
| 3  |  Facebook|   56  |
### - Locations
| ID | Name | Address | Avg Score
| -- |:--------:| ----------:|  -----:|
| 1  |  Chipotle|     33 3rd St     |    4
