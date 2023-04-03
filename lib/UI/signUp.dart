import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../UI/login.dart';
import '../UI/dashboard.dart';



class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {

  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  var _nameController = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              height: 550,
              child: Padding (
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(),
                        child: const Text('Sign Up', style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          // decoration: TextDecoration  `.underline
                        ),),
                      ),
                      
                      TextFormField(
                        onChanged: (value){
                          _nameController = value;
                        },
                        validator: (value){
                          if(value != null){'Please Enter Your Name';}
                          else
                          { null;}
                        },
                        decoration: const InputDecoration(
                            labelText: 'Full Name'
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            labelText: 'Email'
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email)=>
                        email !=null && !EmailValidator.validate(email)
                            ?"Enter a valid email": null,
                      ),

                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                            labelText: 'password'
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value)=>value != null && value.length<6
                            ? 'enter a minimum of 6 characters'
                            : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(300, 40),
                              shape: const StadiumBorder(),
                            ),
                            onPressed: signup,
                            child: const Text('Next')
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an Account:'),
                            TextButton(
                                onPressed: (){
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context)=> const Center(child: CircularProgressIndicator(),)
                                  );
                                  Navigator.push(context,
                                    MaterialPageRoute(builder:
                                        (context) =>
                                        login(),
                                    ),);
                                },
                                child: const Text('Login',
                                  style: TextStyle(
                                      fontSize: 17
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signup() async {
    final isValid = formkey.currentState!.validate();
    if(!isValid)return;
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) => Center(child: CircularProgressIndicator(),)
    // );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await FirebaseAuth.instance.currentUser?.updateDisplayName(_nameController);

    } on FirebaseException catch (e) {
      print(e);

    }
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder:
          (context) =>
          dashboard()
      ),);
  }
}



