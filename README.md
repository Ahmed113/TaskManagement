# task_management

A Flutter app for task management.

## Getting Started

This project is a starting point for a Flutter application.
The Task Management app is built with a clean architecture. It's a responsive app with the Flutter screenUtil package.
Hive is the local storage used for our app, and Firestore is used for remote storage.
bloc is the used state management.
The application is compatible with both Android mobile devices and Windows desktop platforms.

## Installation
The application is built using Flutter version 3.22.0.
- For Android mobile devices:
  1- Clone the repository to your development environment, such as Visual Studio Code or Android Studio.

  2- Execute the following command to fetch the dependencies:

    `flutter pub get`

  3- Build the application in debug mode by running:

    `flutter build apk --debug`

- For Windows desktop platforms:

  1- Clone the repository to your Visual Studio Code environment.

  2- Ensure that your Flutter project is configured to support desktop platforms by executing the following command:

    `flutter config --enable-windows-desktop`

  3- Build and run the application by executing:

    `flutter run -d windows`

  > **Note:** Ensure that you have the latest version of Visual Studio Code installed, with desktop development support for C++ enabled. Additionally, install the C++/CLI build tools within Visual Studio Code.
  
  
