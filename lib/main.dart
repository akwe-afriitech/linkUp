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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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

