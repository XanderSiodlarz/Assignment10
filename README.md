Notes is an app designed to simulate the mobile notes app. 

Notes was designed and coded with swift and SwiftUI. It upholds the MVVM (Model, View, View-Model) format. Firebase is used for authentication and storage.

Models: The models created and used in this project are CredentialModel, which is used for the purpose to aid in the authentication process, and NotesModel, which is used to aid in creating/storing the notes.


Views: 

  CredView: This is the view to either sign up or login. If the credentials for login don't match with any users in FireAuth, then an warning will pop up and the user will not be able to login with the false credentials. Furthermore, If the user does not present valid credentials for the sign up process(valid email and password of at least 6 characters) a pop will warn saying the user cannot creete an account until the qualifications have been met.
  
  NoteBankView: Thie view show all notes created by the logged in user. Utilizing FireStore, a user can also create new notes, delete individual notes, or delete all notes. Utilizing FireAuth, a user can log out from the session
  
  NoteDetail: This view is shown after a user decides to create a new note. Here, the user will enter a note title and description(the actual note). Once save is clicked the user will be returned to the NoteBankView for following actions.

  
ViewModel: 
  NotesViewModel: This file contains all functions used in other files, while utilizing the files in the Models folder as well. creating environment object variables in the views files the special functions in this class are able to be used, such as authentication functions, and storing/updating/deleting functions.

Firebase:

  Firestore: Used for storing notes in databases so each user can see all of their current existing notes every session
  
  FireAuth: Used for validating credentials and login/signup. This is done via email/password. 

  

  
