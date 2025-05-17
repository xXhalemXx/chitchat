# ChitChat App
The ChitChat App is a powerful Chat application used to communicate with your friends or your family.

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Usage](#usage)
- [Installation](#installation)
- [Credits](#credits)
- [Contributing](#contributing)
- [Contact](#contact)

## Introduction

The Chit Chat app is a dynamic communication platform designed to keep users connected in real time. Whether you're chatting one-on-one or engaging in group conversations, this app offers a seamless experience for instant messaging, voice calls, and video calls. Built using Flutter and Firebase, Chit Chat ensures smooth and efficient interactions, with WebRTC technology enabling high-quality voice and video communication. Your conversations remain secure and accessible.

---

## Features
### 🌟 Core Features:
✔ **Instant Messaging** – Seamless real-time text-based chats  
✔ **Voice & Video Calls** – High-quality calls with WebRTC   
✔ **Active Status Indicators** – Know when friends are online  

### 🔜 Upcoming Features:
🔹 **Media Sharing** – Send images, videos, and documents  
🔹 **Push Notifications** – Stay updated with message alerts 
---
  
## Usage

### **Splash Screen**
 **Splash Screen for Android < 12.0**  
   The splash screen is displayed on devices running Android versions below 12.0.  
<p align="center">
<img src="https://github.com/user-attachments/assets//33062776-3dad-4b10-a68a-827391ebfe52"  width="300" height="600">
  
---
  
### **onboarding Screen**
  Where users can choose a way to log in or create a new account
<p align="center">
<img src="https://github.com/user-attachments/assets/c0b9f292-b1c1-4891-894d-5632b87c0332"  width="300" height="600">
  
---
  
### Signup
 **User Signup Page**  
   The signup screen is where users can create a new account. 
<p align="center">
<img src="https://github.com/user-attachments/assets/bd29021d-fb60-47db-b431-3b49d814f827"  width="300" height="600">

 **Text Field Validation**  
   Real-time validation of input fields to ensure data accuracy during signup.
<p align="center">
<img src="https://github.com/user-attachments/assets/9464cf96-26cf-4145-905d-abdedcb3a821"  width="300" height="600">
<img src="https://github.com/user-attachments/assets/d0459ba3-e329-4218-b047-cefb30852183"  width="300" height="600">

**Error and Exception Handling**  
   Examples of error messages are displayed during signup for invalid inputs or server issues. 
<p align="center">
<img src="https://github.com/user-attachments/assets/8c31b766-7f38-4bfb-832a-085aef80d3bf"  width="300" height="600">
  
---
  
### Login
 **User Login Page**  
   The login screen is where users can securely access their accounts. 
<p align="center">
<img src="https://github.com/user-attachments/assets/9afae90b-61d6-4a1d-856e-e32716f501b1"  width="300" height="600">

 **Text Field Validation**  
Real-time validation of login credentials to ensure correct input.
<p align="center">
<img src="https://github.com/user-attachments/assets/878baa00-9bf3-43ba-bfb2-a7a09b656557"  width="300" height="600">
<img src="https://github.com/user-attachments/assets/fb92f458-985e-4b63-892c-ea826d6aa406"  width="300" height="600">

 **Login Using Gmail**  
   The user can use the Google icon to log in automatically using their Gmail account. 
<p align="center">
<img src="https://github.com/user-attachments/assets/7f60142a-30be-482f-b3de-7821ff8b323c"  width="300" height="600">
  
---
  
### Home Page
 **Home Page**  
    where the user can see all chats and select any  one of them.  
<p align="center">
<img src="https://github.com/user-attachments/assets/237f7bb2-1189-4692-a18f-60edefe5aede"  width="300" height="600">
  
 **Home Page with No Chats**  
  The home page is displayed when no chats are available. 
<p align="center">
<img src="https://github.com/user-attachments/assets/e56ac797-de3e-492a-b160-f372af888a47a"  width="300" height="600">

 **Home page with unread Messages**
When there are unread messages, it will show this red circle with the number of messages.
<p align="center">
<img src="https://github.com/user-attachments/assets/39c8081e-a977-4bdc-b5ea-a3e785bdbde3"  width="300" height="600">
  
 **Home page with Active statuses**
When there is an active user, a green dot is shown in their dot, and the last seen time is active now.
<p align="center">
<img src="https://github.com/user-attachments/assets/62eb2a5c-9aab-4609-b7c3-531325af592d"  width="300" height="600">
  
---
  
### chat page
 Chat page where the user can chat with any one of his friends.
<p align="center">
<img src="https://github.com/user-attachments/assets/165f253c-49fb-4eb8-8c0f-25abab10e689"  width="300" height="600">
  
---
  
### outgoing call
<p align="center">
<img src="https://github.com/user-attachments/assets/a3ab2f68-933e-4957-a105-d7457d085480"  width="300" height="600">
  
---
  
### incoming call
<p align="center">
<img src="https://github.com/user-attachments/assets/4c6e6ae9-86d4-483f-b6ed-615c4f081666"  width="300" height="600">
  
---
  
## Next Features will be added soon 😢
---

## **Credits**
One of the most important helpers in this project is the third-party packages. Below is a list of the key dependencies used:

| Dependency               | Version      | Description                                                  |
|--------------------------|--------------|--------------------------------------------------------------|
| flutter_screenutil       | ^5.9.3       | Used for responsive design.                                  |
| flutter_bloc             | ^9.0.0       | State management using the BLoC pattern.                     |
| bloc                     | ^9.0.0       | Provides core BLoC functionalities.                          |
| equatable                | ^2.0.7       | Simplifies value comparisons in Dart.                        |
| flutter_native_splash    | ^2.4.1       | Generates custom splash screens for the app.                 |
| flutter_svg              | ^2.0.10+1    | Renders SVG images in Flutter.                               |
| google_sign_in           | ^6.2.1       | Supports Firebase authentication using Google.             |
| firebase_auth            | ^5.1.4       | Provides Firebase authentication functionalities.            |
| firebase_core            | ^3.3.0       | Core Firebase functionalities for initialization.            |
| cupertino_icons          | ^1.0.6       | Provides iOS-style icons for Cupertino-based apps.           |
| get_it                   | ^8.0.3       | Dependency injection and service locator.                    |
| flutter_facebook_auth    | ^7.0.1       | Enables Facebook authentication integration.                 |
| flutter_slidable         | ^3.1.1       | Adds slidable widget functionality for interactive lists.    |
| cloud_firestore          | ^5.4.5       | Integrates Cloud Firestore for real-time database operations.  |
| shared_preferences       | ^2.3.3       | Saves user data locally via key-value storage.               |
| flutter_secure_storage   | ^9.2.4       | Provides secure local storage for sensitive data.            |
| cached_network_image     | ^3.4.1       | Efficiently caches images fetched from the network.          |
| intl                     | ^0.20.1      | Offers internationalization and localization support.        |
| flutter_webrtc           | ^0.12.11     | Enables voice and video communication using WebRTC.          |
| audioplayers             | ^6.2.0       | Plays audio files, useful for call ringtones and alerts.       |

 
 
## Installation

To run this app, you need to have Flutter installed on your machine. You can follow the  [official documentation](https://www.freecodecamp.org/news/how-to-write-a-good-readme-file/)  to set up Flutter.

To run the app on an emulator or a physical device, run the following command in the terminal:

```bash
flutter run

```


To build the app for production, run the following command in the terminal:

```bash
flutter build apk

```


## Contributing

This project is open for contributions. If you want to contribute to this project, please follow these steps:

-   Fork this repository
-   Create a branch with your feature or bug fix name
-   Commit and push your changes
-   Create a pull request

## Contact

If you have any questions or feedback, please feel free to contact me at mohamedhalem909@gmail.com.
