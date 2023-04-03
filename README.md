<div align='center'>
    <h1><b></b> LinkUp</h1>
 
    <p>A mobile and webapplication to link up hospitals globally by sharing data of the services, location and other facilities that each global hospital owns. In this way users can see exactly hospital and the services the offer
</p>

</div>

* For Mobile:[https://github.com/akwe-afriitech/e-life-save/](https://github.com/akwe-afriitech/LinkUp) (stable channel)


## Getting Started /🗒️ **INSTALLATION**


### This code is running on the following versions

** Flutter version `3.7.8` (Channel stable)

** Android SDK `33.0.0` (Android SDK version 33.0.0 or higher)

** gradle version `8.0.2`

** Windows Version `windows 10` (Installed a version of Windows 10 or higher)

** Android Studio version `2020.3`  (or higher)

** VS Code version `1.76.1` (or higher)


### Local Installation 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/akwe-afriitech/linkUp/
```

**Step 2:**
Go to the projects directory in your IDE's terminal by using `cd` then paste directory path to root file of the project

```
cd 'paste path to root file of the project'
```


**Step 3:**

From the projects root, execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 4:**

After all dependencies have being gotten `run` the app on emulator or mobile using the the command 

```
flutter run lib/main.dart
```
Wait for app to build and proceed to test.



## LinkUp Features:

* Login
* Signup
* Display Global Hospital
* Show Services
* Database
* Show hospital contact info
* show hospital location on map



### Up-Coming Features:

* Google Maps Location for Hospitals
* User firebase push Notifications for new hospitals
* Connectivity Support
* Background Fetch Support

### Libraries & Tools Used

** [firebase Database](firebase.com)


### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- node-modules
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- auth/
|- UI/
|- main.dart

```

Now, lets dive into the lib folder which has the main code for the application.

```
1- auth - All the login functionality and navigation functionality to the required screens
2- ui — Contains all the ui of your project, contains sub directory for each screen.
3- main.dart - This is the starting point of the application. All the applications level of configurations are defined in this file i.e, theme, routes, title, orientation etc.
```

### auth

This directory all the login functionality and navigation functionality to the required screens. A separate file is created for each type as shown in example below:

```
auth/
|- init.dart
```

### UI

This directory contains all the ui of your application. Each screen is located in a separate folder making it easy to combine group of files related to that particular screen. All the screen specific widgets will be placed in `widgets` directory as shown in the example below:

```
ui/
|- .....

```

### Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.

```
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/init.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCeajJfDgq3znMdwEAvMB7wpYCRmTtOv2s",
        authDomain: "linkup-d2e57.firebaseapp.com",
        projectId: "linkup-d2e57",
        storageBucket: "linkup-d2e57.appspot.com",
        messagingSenderId: "160583327704",
        appId: "1:160583327704:web:c5236e37b714c1665d9cad",
        measurementId: "G-VV6LV752WW"
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LinkUp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot){
          if(snapshot.hasError){
            print('error');
          }
          if(snapshot.connectionState == ConnectionState.done){
            return init();
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}


```



## Conclusion

I will be happy to answer any questions that you may have on this approach, and if you want to lend a hand with the linkUp project then please feel free to submit an issue and/or pull request 🙂


