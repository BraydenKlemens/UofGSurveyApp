# UofG Survey App
A survey hub for survey particpants involved in University of Guelph research data collection. This app streamlines
survey collection by giving particpants a container for all of the research surveys they intend to complete.

## Features
- Create/delete/login using University of Guelph emails.
- Each user recieves survey data linked to thier account from cloud firestore service upon logging into the app.
- Users can track in progress and complete surveys through a convenient UI.
- The app will send notifications to the user once a week if they have outstanding surveys to complete.
- Users have acess to a history log of surveys
- Profile page to manage an account.

## To Build:
Run XCode IOS or Android Studio emulator
```
survey_app/
flutter run
```

## Tech Stack
- Flutter as the main framework
- Firestore as the db
- Firebase Authentication for managing users
- Provider for state management
- WebViewer to run Qualtrics surveys

## App Pictures
![Screen Shot 2022-04-19 at 2 50 13 AM](https://user-images.githubusercontent.com/40216205/193905938-7b06dae4-e735-4bfb-93ca-8fc5a15ba93d.png)
![Screen Shot 2022-04-19 at 2 44 06 AM](https://user-images.githubusercontent.com/40216205/193905920-fb6537f1-8fa9-4269-874d-d3c227d4fa63.png)
![Screen Shot 2022-04-19 at 3 18 39 AM](https://user-images.githubusercontent.com/40216205/193905955-1df80bd9-2c65-445f-ba4f-ec1d9f29cf98.png)
<img width="308" alt="history" src="https://user-images.githubusercontent.com/40216205/193906079-dbf630a6-91c4-491e-99eb-37c69e246ae4.png">

