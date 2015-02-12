# Grasshopper Front-end

A messageboard API served up as JSON by **Ruby on Rails** and consumed by **AngularJS**.

This is the Angular Front-end that I wrote for the API. The Rails counterpart is found here:

http://github.com/jaeming/grasshopper

The API is live:
grasshopperapi.herokuapp.com

Or the Angular Front-end can be found here:
http://grassy.shufflebox.org

I started this project to learn more about building a RESTful API in Rails.
Then, I began to experiment with building a front-end using AngularJS to better understand how both ends actually connect.


____________
#DOCUMENTATION


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

```POST   /users```

```POST   /user/sign_in```

```POST   /user/sign_up```

```GET    /user/current_user```

```GET    /user/sign_out```


______
#Usage
______

###User & Users:

####First a word on Authentication
Authentication is now token-based, in which all authenticated requests must pass a token in the header. Previously I had a session/cookies approach but this was not ideal due to users who have 3rd party cookies disabled. A password is still required however, as I wanted to leave the option of handling the token transparently on the client side (see more below on this).

On sign-up or sign-in, a new token is generated and returned one time only in the JSON response. You can grab this token on the client side so that it can be handled without the user having to worry about it.  I used HTTP Store in my angular app for this purpose. Something like:

```localStorage.setItem('auth_token', data.auth_token);```

...in the Success promise, which can then be retrieved later with:

```var userToken = localStorage.getItem('auth_token');```


In my angular app I then use:

```$http.defaults.headers.common["Authorization"] = "Token token=" + userToken;```

…which will set the Authorization header for each request.

CURL would pass the token with a flag like this:

```-H "Authorization: Token token=1d1d200abe254195b04937e47a8a80db"```

######POST actions:
######/users
Post to the /users path to create a new user.
*Required fields are **email**, **name**, **password**, and **password_confirmation**.

Using CURL, a new user signing up might look something like this:

```
curl -XPOST -H "Content-Type: application/json" "http://grasshopperapi.herokuapp.com/users/" -d '{"email": "lulu@test.com", "name": "lulu" "password": "secret", "password_confirmation": "secret"}'
```
######/user/sign_in
Post to the above endpoint to sign in.
*Required fields are **email**, and **password**.

Sign in example with CURL:

```
curl -XPOST -H "Content-Type: application/json" "grasshopperapi.herokuapp.com/user/sign_in" -d '{"email": "tester@test.com", "password":"secret"}'
```

Upon successfully verifying your password, the token will be supplied like such:

```{"auth_token":"df215c5033c7444dac8556eb560686d2"}```

Grab this and use it client side for all authenticated requests.  If the token gets lost, sign up again to get a new one generated.

######GET actions:
######/user/current_user

```/user/current_user``` is a special path that will return the details of the user currently signed in. This will provide you will the following details:

```{"success":"true","message":"You are signed in","email":"luckycat@test.com","name":"luckycat","id":17}```

If the user token was not able to be authenticated, it will return:

```{"success":"false","status":"You are not signed in","message":"Sign in / Sign up"}```

######/user/sign_out
An authorized get request with the user's token to this endpoint will result in the user's token being set to nil, which effectively makes all authenticated requests unavailable thereafter.  You will need to sign the user in again to get a new token.  while performing the sign out action, you may wish to empty out your saved token on the client-side as well. Example with localstorage:

```
localStorage.removeItem('auth_token');
```

##Boards & Messages:

######GET

In the case of Boards and Messages, **Get** will retrieve an Index or a specific board or message if an id is supplied. Keep in mind that messages are nested within a specific board so you will need to specify both the board is as well as the message id for retrieving single messages. retrieving the board index:

```
http://grasshopperapi.herokuapp.com/boards
```

as opposed to retrieving a specific single board:

```
http://grasshopperapi.herokuapp.com/boards/2
```

message index:

```
http://grasshopperapi.herokuapp.com/boards/2/messages
```

or a specific message:


```
http://grasshopperapi.herokuapp.com/boards/2/messages/4
```


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

```
http://grasshopperapi.herokuapp.com/search?q=pizza
```

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


If you have any specific questions about the API or the Angular JS Front-end example, please get in touch at daylightsavings@gmail.com.
