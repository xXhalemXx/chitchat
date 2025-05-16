# ChitChat App
The ChitChat App is a powerful Chat application used to communicate with your friends or your family.

## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Installation](#installation)
- [Run App Now](#run-app-now)
- [Credits](#credits)
- [Contributing](#contributing)
- [Contact](#contact)

## Introduction

The Chit Chat app is a dynamic communication platform designed to keep users connected in real time. Whether you're chatting one-on-one or engaging in group conversations, this app offers a seamless experience for instant messaging, voice calls, and video calls. Built using Flutter and Firebase, Chit Chat ensures smooth and efficient interactions, with WebRTC technology enabling high-quality voice and video communication. Your conversations remain secure and accessible.

  
## Usage

### **Splash Screen**
1. **Splash Screen for Android < 12.0**  
   The splash screen is displayed on devices running Android versions below 12.0.  
<p align="center">
<img src="https://github.com/user-attachments/assets//33062776-3dad-4b10-a68a-827391ebfe52"  width="300" height="600">

### Signup
3. **User Signup Page**  
   The signup screen where users can create a new account. 
<p align="center">
<img src="https://github.com/user-attachments/assets/bd29021d-fb60-47db-b431-3b49d814f827"  width="300" height="600">

4. **Text Field Validation**  
   Real-time validation of input fields to ensure data accuracy during signup.
<p align="center">
<img src="https://github.com/user-attachments/assets/9464cf96-26cf-4145-905d-abdedcb3a821"  width="300" height="600">
<img src="https://github.com/user-attachments/assets/d0459ba3-e329-4218-b047-cefb30852183"  width="300" height="600">

5. **Error and Exception Handling**  
   Examples of error messages displayed during signup for invalid inputs or server issues. 
<p align="center">
<img src="https://github.com/user-attachments/assets/8c31b766-7f38-4bfb-832a-085aef80d3bf"  width="300" height="600">

### Login
7. **User Login Page**  
   The login screen where users can securely access their accounts. 
<p align="center">
<img src="https://github.com/user-attachments/assets/846a4082-6fe3-4c15-b582-b784996bf57c"  width="300" height="600">

8. **Text Field Validation**  
   Real-time validation of login credentials to ensure correct input.
<p align="center">
<img src="https://github.com/user-attachments/assets/eeac31f4-6be4-4516-b52f-32fdb2482e29"  width="300" height="600">
  
9. **Error and Exception Handling**  
   Examples of error messages displayed during login for invalid credentials or server issues. 
<p align="center">
<img src="https://github.com/user-attachments/assets/55c6bb82-6fff-43c9-9f2f-0fb74eb55c44"  width="300" height="600">

### Home Page
10. **Home Page Loading State**  
    The loading state displayed while fetching tasks from the server or local database.  
<p align="center">
<img src="https://github.com/user-attachments/assets/e2359b00-e305-45f3-86f2-55ee63cdf920"  width="300" height="600">
<img src="https://github.com/user-attachments/assets/a929f0f7-55ad-451a-8b98-60018d04b985"  width="300" height="600">

11. **Home Page with No Tasks**  
    The home page displayed when no tasks are available. 
<p align="center">
<img src="https://github.com/user-attachments/assets/ecca6aa7-a29a-4f1c-b052-0e78f6c2ee1a"  width="300" height="600">
  
12. **Home Page with Tasks**  
    The home page after tasks have been added, displaying all tasks in a clean and organized layout. 
<p align="center">
<img src="https://github.com/user-attachments/assets/d5c7af9f-ae23-46a8-90ae-a82a1241c1bb"  width="300" height="600">

13. **Offline Task Sync Indicator**  
    A sync icon is displayed next to tasks that were added or modified offline. Once online, these tasks are automatically synced with the server. 
<p align="center">
<img src="https://github.com/user-attachments/assets/fe8c6e94-a62a-4f6c-8b6d-46fbb5815074"  width="300" height="600">

14. **Task Management by Category**  
    Users can filter tasks by categories such as **New Tasks**, **Outdated**, **Completed**, and **In Progress**.  
<p align="center">
<img src="https://github.com/user-attachments/assets/2d025519-5290-4857-97b7-84dd87b66b8c"  width="300" height="600">
<img src="https://github.com/user-attachments/assets/d1b6db79-765c-4755-a809-8023623c87dc"  width="300" height="600">
<img src="https://github.com/user-attachments/assets/1f8a91f8-c5dd-4776-9da7-07de1d41ba69"  width="300" height="600">

**Task Status Update Dialog**  
    A dialog box allows users to update the status of a task (e.g., pending, in progress, completed). 
<p align="center">
<img src="https://github.com/user-attachments/assets/738c05f0-e0d0-43c1-ae38-aea4d3a9374b"  width="300" height="600">

16. **Task Status Update Results**  
    Visual feedback after updating a task's status.  
<p align="center">
<img src="https://github.com/user-attachments/assets/b054f177-5df4-476c-90e5-15d197dc90b8"  width="300" height="600">
<img src="https://github.com/user-attachments/assets/8e17978c-9e13-4578-a73b-ac7c1bab3643"  width="300" height="600">
<img src="https://github.com/user-attachments/assets/08b61eb9-c6d4-424e-a8c7-80b9a0926733"  width="300" height="600">

17. **Task Filters**  
    Users can apply filters to view tasks based on specific criteria.
<p align="center">
<img src="https://github.com/user-attachments/assets/0df3d967-661c-49ac-957d-64d8d2797fd3"  width="300" height="600">

### Create Task 
18. **Create Task Page**  
    The screen where users can add new tasks with details such as title, description, and due date. 
<p align="center">
<img src="https://github.com/user-attachments/assets/206fd99c-a437-4e3f-a9fc-ec353f72e4ba"  width="300" height="600">

19. **Create Task Field Validation**  
    Real-time validation of input fields to ensure all required details are provided.
<p align="center">
<img src="https://github.com/user-attachments/assets/3d480b96-9119-4c18-a354-e3479b8c2109"  width="300" height="600">
  
20. **Task Created Successfully**  
    Confirmation message displayed after a task is successfully created. 
<p align="center">
<img src="https://github.com/user-attachments/assets/ce9e403f-9ba4-403c-945d-05f8d45621ed"  width="300" height="600">
  
21. **Error During Task Creation**  
    Error message displayed if task creation fails due to invalid inputs or server issues.  
<p align="center">
<img src="https://github.com/user-attachments/assets/41290a2f-b3ed-494f-bb50-35b8c63f57b9"  width="300" height="600">

### Profile
22. **Profile Page**  
    The profile screen where users can view and update their personal information. 
<p align="center">
<img src="https://github.com/user-attachments/assets/3d6a3753-7b2c-4e77-b25d-084d209e6a68"  width="300" height="600">
  
23. **Profile Page Validation**  
    Real-time validation of profile fields to ensure accurate updates.
<p align="center">
<img src="https://github.com/user-attachments/assets/ff91f031-9e4e-4262-9e12-e64a1e203384"  width="300" height="600">

### common use
24. **Fully Offline Functionality**  
    The app works seamlessly offline, allowing users to add, edit, or delete tasks without an internet connection. Changes are synced with the server once connectivity is restored.  
<p align="center">
<img src="https://github.com/user-attachments/assets/f9d15aac-5df7-4f11-8fcf-08827696a2bf"  width="300" height="600">  
  
25. **Persistent Login**  
    Users are securely logged in after their first login, and their credentials are saved until the session token expires.  
<p align="center">
<img src="https://github.com/user-attachments/assets/37551934-7ed4-43f2-b1bb-4a2d689dcce5"  width="300" height="600">  






## **Credits**
One of the most important helpers in this project are the third-party packages. Below is a list of the key dependencies used:

| Dependency               | Version    | Description                                |
|--------------------------|------------|--------------------------------------------|
| flutter_bloc             | ^9.0.0     | State management using the BLoC pattern.   |
| bloc                     | ^9.0.0     | Core BLoC library for state management.    |
| equatable                | ^2.0.7     | Simplifies equality comparisons for objects.|
| get_it                   | ^8.0.3     | Dependency injection for Flutter apps.     |
| dio                      | ^5.8.0     | Powerful HTTP client for making API requests.|
| pretty_dio_logger        | ^1.4.0     | Logs Dio HTTP requests and responses in a readable format.|
| flutter_screenutil       | ^5.9.3     | Makes the app responsive across different screen sizes.|
| flutter_svg              | ^2.0.17    | Renders SVG images in Flutter.             |
| flutter_native_splash    | ^2.4.4     | Generates native splash screens for Flutter apps.|
| dropdown_button2         | ^2.3.9     | Customizable dropdown buttons for Flutter. |
| intl                     | ^0.20.2    | Internationalization and localization support.|
| calendar_date_picker2    | ^1.1.8     | Customizable date picker for Flutter.      |
| shared_preferences       | ^2.5.1     | Stores simple key-value pairs locally.     |
| flutter_secure_storage   | ^9.2.4     | Securely stores sensitive data locally.    |
| shimmer                  | ^3.0.0     | Adds shimmer effects for loading states.   |
| hive                     | ^2.2.3     | Lightweight and fast local database.       |
| hive_flutter             | ^1.1.0     | Flutter integration for Hive database.     |
| connectivity_plus        | ^6.1.2     | Monitors network connectivity status.      |


 
 
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

## Run app now
You can use live demo on this link [play app](https://appetize.io/app/b_4xz6jnxi57obodysqcepn6jaqa).

## Contributing

This project is open for contributions. If you want to contribute to this project, please follow these steps:

-   Fork this repository
-   Create a branch with your feature or bug fix name
-   Commit and push your changes
-   Create a pull request

## Contact

If you have any questions or feedback, please feel free to contact me at mohamedhalem909@gmail.com.
