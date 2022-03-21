This is a Marvel Demo app.

## This app is created to list marvel characters in your iPhone and one can check the details by selecting the characters from the list.    

## About the app

This app is created using MVVM design pattern which also includes the test cases for the app.

The app is build using UIKit framework

External libraries used - Kingfisher for image caching

This app uses the *Marvel API* i.e https://developer.marvel.com/ to list the marvel characters and related comics list.

## Features in the app

*CharactersList* : This screen displays all the marvel characters fetched from the API. It have an pagination integrated which gets 10 Marvel characters at a time from the server. As you will reach to the bottom of the list, The app will automatically fetch more characters and will keep adding in the list. It dispays the short description, Name and image of the character.

*CharacterDetails* : This screen displays the Image, full description, name and comics related to the character in the screen.


****** Technical Details ******

Extensions have been used for md5 hashing and Tableview load more feature.

<img width="653" alt="Screenshot 2022-03-21 at 7 00 42 PM" src="https://user-images.githubusercontent.com/92414686/159271324-23150652-b498-41bf-b56c-5a434057e35b.png">


An API Helper class has been used for the API intregration work.

*Architecture* : This app is developed using MVVM design pattern which includes three layer i.e Model, View and View model.

*Model* : This layer includes parsing of the json coming from the server.

*View* : This layer is reponsible performing the UI Related actions and has the View Controllers.

*ViewModel* : This layer contains the business logic.

## To Run the app

1. Download/Clone the app from the github
*Command to clone the app* : Open terminal and use this command *git clone https://github.com/bhaswar01/marvel-demo.git to clone the app.

*API Keys* : You can create your own API keys(From : https://www.marvel.com/signin?referer=https%3A%2F%2Fdeveloper.marvel.com%2Faccount) and use it in the app.
