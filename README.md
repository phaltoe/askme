== README

The goal of this project is to build an APP that can:

***Users***
1 - Create Questions
2 - Provide Answers
3 - Add Categories to Questions
4 - Edit Own Questions 
5 - Destroy Own Questions

***Moderators***
1 - All of the above in anyone's Questions/Answers

***Admin***
1 - Can do anything

---------------

***RELATIONSHIPS***

* Question has many answers
* Question has many answerers(users) through answers
* Question belongs to an user

* Answer belongs to a question
* Answer belongs to an answerer(user)

* User has many authored_questions
* User has many answers 
* User has many answered_questions through answers

---------------

*How can I create a new question for an user?*

*How can I query the author(user) of a question?*

*How can I find all the questions a user has answered on?*

