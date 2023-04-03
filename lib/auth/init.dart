import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../UI/dashboard.dart';
import '../UI/signUp.dart';


class init extends StatefulWidget {
  const init({Key? key}) : super(key: key);

  @override
  State<init> createState() => _initState();
}
final user = FirebaseAuth.instance.currentUser;

class _initState extends State<init> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData){
              return dashboard();
            }else {
              return signUp();
            }
          }),
    );
  }
}




