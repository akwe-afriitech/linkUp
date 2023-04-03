import 'dart:async';
import 'package:flutter/material.dart';
import 'package:linkup/UI/dashboard.dart';


class submitted extends StatefulWidget {
  const submitted({Key? key}) : super(key: key);

  @override
  State<submitted> createState() => _submittedState();
}

class _submittedState extends State<submitted> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds:2),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                const dashboard()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350.0,
          height: 250.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(50),
              border: Border.all(color:Colors.blue,width: 6.0),
              shape: BoxShape.circle
          ),
          child: const Text("Submitted Successfully",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
