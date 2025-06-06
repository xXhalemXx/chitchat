# ChitChat App
The ChitChat App is a powerful Chat application used to communicate with friends and family.

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
 **Splash Screen for Android > 13.0**  
   The splash screen is displayed on devices running Android versions 13.0 and above.  
<p align="center">
<img src="https://github.com/user-attachments/assets//74667931-b8b7-4889-a3a7-8ba2fcc99f08"  width="300" height="600">

 **Splash Screen for Android < 12.0**  
   The splash screen is displayed on devices running Android versions 12.0 and below.  
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
  
### incoming call (video/audio)
<p align="center">
<img src="https://github.com/user-attachments/assets/02667d52-295b-49f1-91c3-b467ecef5a31"  width="300" height="600">
<img src="https://github.com/user-attachments/assets/483ddd7c-eaea-4afe-9b36-ad8c1c91f20c"  width="300" height="600">

---
  
### diffrant responses
**When receiver cancels**
<p align="center">
<img src="https://github.com/user-attachments/assets/676b4783-52ac-4862-ae2f-cdf41e205149"  width="300" height="600">
  
**receiver didn't answer or reject after 30s**
<p align="center">
<img src="https://github.com/user-attachments/assets/40c64696-d939-420c-a769-85abb06490c3"  width="300" height="600">
  
**receiver accepted audio call**
<p align="center">
<img src="https://github.com/user-attachments/assets/c172444e-7980-4201-b1ea-48aca522a7b8"  width="300" height="600">
  
**receiver accepted video call**
<p align="center">
<img src="https://github.com/user-attachments/assets/1b56108d-bfa0-42b5-ba2f-2e23f83ecab9"  width="300" height="600">
<img src="https://github.com/user-attachments/assets/18e6d5b2-644b-4a82-aea0-0798f97dc295"  width="300" height="600">

---
### Call History page
<p align="center">
<img src="https://github.com/user-attachments/assets/29ed665c-4c50-4ea5-a1b4-016131a14067"  width="300" height="600">
  
---
### Contacts page
<p align="center">
<img src="https://github.com/user-attachments/assets/51ec31af-2465-44a8-b0a9-f8db7c657fde"  width="300" height="600">
  
---
### Settings page
<p align="center">
<img src="https://github.com/user-attachments/assets/a5763d26-eef5-4a59-a681-bf5bd21e9963"  width="300" height="600">
   
**Upload new Image dialog**
<p align="center">
<img src="https://github.com/user-attachments/assets/b69adf45-0d7d-434d-85d9-d613df109988"  width="300" height="600">

  
**Upload a new Image using the camera**
<p align="center">
<img src="https://github.com/user-attachments/assets/e45c56dd-19e1-43f3-8ea0-a8c16cf143cd"  width="300" height="600">
</p>

<br>

**Upload a new Image using the Gallery**
<p align="center">
<img src="https://github.com/user-attachments/assets/00a10db1-94f5-4902-8595-49b19c3c3e85"  width="300" height="600">
</p>

**Adjust image size**  
<br>  
<p align="center">
<img src="https://github.com/user-attachments/assets/6aee08c6-d085-499c-9359-9f93b91c3819"  width="300" height="600">
</p>

**Change Name**  
<br>  
<p align="center">
<img src="https://github.com/user-attachments/assets/27425e29-1cfd-4388-bbe1-66be257ce60b"  width="300" height="600">
</p>

**Change bio**  
<br>  
<p align="center">
<img src="https://github.com/user-attachments/assets/00f7d413-ab22-4054-ab91-763008073cdc"  width="300" height="600">
</p>

**Final profile page**  
<br>  
<p align="center">
<img src="https://github.com/user-attachments/assets/f8ea075d-4482-4ac1-9a3c-fff3d7b98a72"  width="300" height="600">
</p>

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
| permission_handler      | ^12.0.0+1   | Manages app permissions dynamically.                      |
| image_picker           | ^1.1.2       | Allows users to pick images from the gallery or camera.   |
| supabase_flutter       | ^2.9.0       | Provides cloud storage for user photos via Supabase.      |
| image_cropper          | ^9.1.0       | Enables cropping and editing images within the app.       |
| flutter_image_compress | ^2.4.0       | Reduces image size for optimized storage and uploads.     |

 
 
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
