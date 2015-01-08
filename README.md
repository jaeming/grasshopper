# Grasshopper API

A messageboard API served up as JSON by **Ruby on Rails** and consumed by **AngularJS**.

I started this project to learn more about building a RESTful API in Rails.
Then, I began to experiment with building a front-end using AngularJS to better understand how both ends actually connect.

The API is live:
grasshopperapi.herokuapp.com

Or the Angular Front-end can be found here:
http://grassy.shufflebox.org

Repo for angular front-end is found here:
http://github.com/jaeming/Grasshopper-angular

____________
#DOCUMENTATION
____
The grasshopper boards were built as a RAILS API in order for me to explore how Rails works as a RESTful JSON-based interface.

The deployment of this project lives at [grasshopperapi.herokuapp.com/boards ](http://grasshopperapi.herokuapp.com/boards)
. or examine it on [github](https://github.com/jaeming/grasshopper).

To fully understand how the API could utilized on the front-end, I have also built an Angular JS front-end, which can be found at [grassy.shufflebox.org ](http://grassy.shufflebox.org/)
. Github link [here](https://github.com/jaeming/Grasshopper-angular).

Hooking into a RESTful API is simple in concept but I thought I'd write a little documentation anyway.

All data is in JSON format.

The endpoints available are:

###Boards:

```GET    /boards```


```POST   /boards```


```PUT    /boards/:id```


```DELETE /boards/:id```
###Messages:

```GET    /boards/:board_id/messages```


```POST   /boards/:board_id/messages```


```PUT    /boards/:board_id/messages/:id```


```DELETE /boards/:board_id/messages/:id```
###User:

```GET    /user/current_user```

```POST   /users```



###Sessions:
```POST   /sessions```

```DELETE /sessions/:id```
###Search
```GET    /search?q=```

______
#Usage
______

###User & Users:

######POST
Post to the /users path to create a new user.
*Required fields are **email**, **password**, and **password_confirmation**.

Using CURL, a new user signing up might look something like this:

```
curl -XPOST -H "Content-Type: application/json" "http://grasshopperapi.herokuapp.com/users/" -d '{"email": "user@test.com", "password": "secret", "password_confirmation": "secret"}'
```

######GET

```/user/current_user``` is a special path that will return the details of the user currently signed in. This will provide you will the following details:

```{"success":"true","status":"You are signed in","email":"karate@chop.com","name":"karate_chop","id":9}```

If the user has not established a session, it will return:

```{"success":"false","status":"You are not signed in","email":"Sign in / Sign up"}```
_________
###Sessions:
First, a note about authentication. For this API I decided to explore a session-based approach using cookies. This has some pros and cons and is not truly a stateless approach when compared to something like Tokens but it suited my needs in this particular case and makes for an easy user approach.

The main thing to keep in mind is that you will need to save a **cookie** when signing in and send a cookie when doing any action that requires authentication (such as creating a new board). With CURL this is as easy as adding ```-c cookies.txt``` option when signing in and sending a ```-b cookies.txt``` option when enacting an authenticated action.

If you were using a web-based front-end, you can use JS to get and send the cookie by enabling the withCredentials option: ```xhr.withCredentials = true;```

In Angular, I achieved this by appending the following config to my application module:

```
.config(['$httpProvider', function($httpProvider) {
  $httpProvider.defaults.withCredentials = true;
}]);
```

######POST
*Required fields are **email** and **password**.

An example of creating a new session (signing in) using CURL:

```
curl -XPOST -H "Content-Type: application/json" -c cookies.txt "http://grasshopperapi.herokuapp.com/sessions/" -d '{"email": "user@test.com", "password":"secret"}'
```

######DELETE
A user can be logged out by destroying the session by id. Lets use an example from Angular this time:

```
$http({method: 'DELETE', url: "http://grasshopperapi.herokuapp.com/sessions/" + $scope.user.id })
```
where the user.id value could be set using the ```/user/current_user```
_________

###Boards & Messages:

######GET

In the case of Boards and Messages, **Get** will retrieve an Index or a specific board or message if an id is supplied. Keep in mind that messages are nested within a specific board so you will need to specify both the board is as well as the message id for retrieving single messages.

retrieving the board index:

```http://grasshopperapi.herokuapp.com/boards```

as opposed to retrieving a specific single board:

```http://grasshopperapi.herokuapp.com/boards/2```

message index:

```http://grasshopperapi.herokuapp.com/boards/2/messages```

or a specific message:


```http://grasshopperapi.herokuapp.com/boards/2/messages/4```


######POST
*Required fields for board are **title** and **text**.

*Required field for message is **body**.

We can create a new board or message with the POST action.
An example creating a new message in board 1:

```
curl -XPOST -H "Content-Type: application/json" -b cookies.txt "http://grasshopperapi.herokuapp.com/boards/1/messages" -d '{"body": "really good message"}'
```

The user must be signed in (have an active session) for to create boards & messages.

######PUT or PATCH
*Required fields for board edits are **title**, **text**, and **id**.

*Required fields for message edits are **body** **id**.

A board or message can be edited through PUT. PATCH is also supported:

```
curl -v -H "Accept: application/json" -b cookies.txt -H "Content-type: application/json" -X
PATCH -d '{"title":"Pragmatic programmers","id":3,"text":"Agile development with Rails second edition"}' http://grasshopperapi.herokuapp.com/boards/1
```

To edit a board or message, the user must be the original creator of that board or message, as well as having an active session.


######DELETE
Simply point your DELETE method at the url of the board or message ID you want gone.


```
curl -i -H "Accept: application/json" -X DELETE http://grasshopperapi.herokuapp.com/boards/1/messages/4
```

To delete a board or message, the user must be the original creator of that board or message, as well as having an active session.
_____________

###Search:

######GET
The search feature is a GET method. Use *search?q=* followed by the serach term to the url and a list of boards and/or messages will be returned with matching results.

Example:

```http://grasshopperapi.herokuapp.com/search?q=pizza```

returns all boards or messages that have the word 'pizza' in it.
_____________

##Available JSON keys

The following JSON data is served by Rails
######Boards:


```
id: 6,
title: "what's your favorite pizza?",
text: "Ever had Sushi pizza???",
user_name: "silly_dog",
created_at: "December 11, 2014",
message_count: 1,
url: "/boards/6"
```

######Messages:

```
board_name: "what's your favorite pizza?",
board_id: 6,
id: 3,
body: "I also like pizza",
user_name: "lizaro",
created_at: "2 days ago"
```

_____________

If you have any specific questions about the API or the Angular JS Front-end example, please get in touch at daylightsavings@gmail.com.













