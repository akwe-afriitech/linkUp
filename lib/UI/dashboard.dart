import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linkup/UI/addHospitals.dart';
import 'package:linkup/UI/hospitalALL.dart';
import 'package:linkup/UI/hospitalLocations.dart';
import 'package:linkup/UI/hospitalServices.dart';
import 'package:linkup/UI/login.dart';
import 'package:linkup/UI/signUp.dart';


class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> newHospitals = FirebaseFirestore.instance.collection('newHospitals').snapshots();
    final Stream<QuerySnapshot> hospital = FirebaseFirestore.instance.collection('hospital').snapshots();

    return Scaffold(
      drawer: Drawer(
        elevation: 20,
        child: ListView(
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text('Welcome'),
                accountEmail: Text('Linkup Hospitals'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person,
                    color: Colors.black,
                    size: 50,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.home,color: Colors.pink,),
                title: Text('Home', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),),
                tileColor: Colors.grey,
              ),
              ListTile(
                leading: const Icon(Icons.local_hospital_rounded ,color: Colors.pink),
                title: const Text('Hospitals', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const hospitalAll()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.medical_services ,color: Colors.pink),
                title: const Text('Services',style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const hospitalServices()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on ,color: Colors.pink),
                title: const Text('Locations',style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const hospitalLocations()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_box ,color: Colors.pink),
                title: const Text('Add New Hospital',style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  const hospitals()));
                },
              ),
              Container(
                width: 20,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: ElevatedButton(
                  child: const Text('signout'),
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ));
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => login(),
                      ),
                    );
                  },
                ),
              ),
            ]
        ),
      ),
      appBar: AppBar(
        title:const Text('Hospitals'),
        centerTitle:true,
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: ((context) => login()),),);
          }, child: const Text('login')),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const signUp(),),);
          }, child: const Text('signup')),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: hospital,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("error loading data");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("loading.....");
                  }
                  final data1 = snapshot.requireData;
                  return Text(
                    "${data1.docs[1]['phonenumber']} ",
                    // style: TextStyle(
                    //   fontSize:30, fontWeight: FontWeight.bold,
                    // ),
                  );
                },
              ),
            ),

            StreamBuilder<QuerySnapshot>(
              stream: newHospitals,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text("error loading data");
                }
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Text("loading.....");
                }
                final data1 = snapshot.requireData;
                return Container(
                  height: 300,
                  child: ListView.builder(
                    itemCount: data1.size,
                    itemBuilder: (context, index){
                      return Container(
                        width: 390.0,
                        height: 235.0,
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.all(15.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.blue, Colors.blueAccent, Colors.white]
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Colors.indigo, width: 2.0)
                        ),
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              width: 177.0,
                              child: Column(
                                children: [
                                  FittedBox(
                                    child: Container(
                                      width: 170,
                                      child: Text("${data1.docs[index]['name']}", style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 25,
                                      ),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.mail),
                                        FittedBox(
                                          child: Text("${data1.docs[index]['email']}", style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                          ),),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.link),
                                        FittedBox(
                                          child: Text(': Click to Visit', style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                          ),),
                                        )
                                      ],
                                    ),
                                  ),

                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          backgroundColor: Colors.white,
                                        ),
                                        onPressed: (){},
                                        child: const Text('View Services Offered', style: TextStyle(color: Colors.indigo),)
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: 177.0,
                                    height: 177.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20.0),
                                        border: Border.all(color: Colors.indigo, width: 2.0)
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: const Icon(Icons.location_on_outlined, color: Colors.white,),

                                        ),
                                        Container(
                                          child: const Text('View Location on map'),

                                        ),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Container(
              width: 390.0,
              height: 235.0,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(15.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue, Colors.blueAccent, Colors.white]
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.indigo, width: 2.0)
              ),
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 177.0,
                    child: Column(
                      children: [
                        FittedBox(
                          child: Container(
                            width: 170,
                            child: const Text("Bamenda Reginal Hospital", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: const [
                              Icon(Icons.mail),
                              FittedBox(
                                child: Text(':  earlmillen7', style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: const [
                              Icon(Icons.link),
                              FittedBox(
                                child: Text(': Click to Visit', style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),),
                              )
                            ],
                          ),
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.white,
                              ),
                              onPressed: (){},
                              child: const Text('View Services Offered', style: TextStyle(color: Colors.indigo),)
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: 177.0,
                          height: 177.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Colors.indigo, width: 2.0)
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              Container(
                                child: const Icon(Icons.location_on_outlined, color: Colors.white,),

                              ),
                              Container(
                                child: const Text('View Location on map'),

                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 390.0,
              height: 235.0,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(15.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue, Colors.blueAccent, Colors.white]
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.indigo, width: 2.0)
              ),
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 177.0,
                    child: Column(
                      children: [
                        FittedBox(
                          child: Container(
                            width: 170,
                            child: const Text("Bamenda Reginal Hospital", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: const [
                              Icon(Icons.mail),
                              FittedBox(
                                child: Text(':  earlmillen7', style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: const [
                              Icon(Icons.link),
                              FittedBox(
                                child: Text(': Click to Visit', style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),),
                              )
                            ],
                          ),
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.white,
                              ),
                              onPressed: (){},
                              child: const Text('View Services Offered', style: TextStyle(color: Colors.indigo),)
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: 177.0,
                          height: 177.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Colors.indigo, width: 2.0)
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              Container(
                                child: const Icon(Icons.location_on_outlined, color: Colors.white,),

                              ),
                              Container(
                                child: const Text('View Location on map'),

                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 390.0,
              height: 235.0,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(15.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue, Colors.blueAccent, Colors.white]
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.indigo, width: 2.0)
              ),
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 177.0,
                    child: Column(
                      children: [
                        FittedBox(
                          child: Container(
                            width: 170,
                            child: const Text("Bamenda Reginal Hospital", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: const [
                              Icon(Icons.mail),
                              FittedBox(
                                child: Text(':  earlmillen7', style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: const [
                              Icon(Icons.link),
                              FittedBox(
                                child: Text(': Click to Visit', style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),),
                              )
                            ],
                          ),
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.white,
                              ),
                              onPressed: (){},
                              child: const Text('View Services Offered', style: TextStyle(color: Colors.indigo),)
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: 177.0,
                          height: 177.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Colors.indigo, width: 2.0)
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              Container(
                                child: const Icon(Icons.location_on_outlined, color: Colors.white,),

                              ),
                              Container(
                                child: const Text('View Location on map'),

                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 390.0,
              height: 235.0,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(15.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue, Colors.blueAccent, Colors.white]
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.indigo, width: 2.0)
              ),
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 177.0,
                    child: Column(
                      children: [
                        FittedBox(
                          child: Container(
                            width: 170,
                            child: const Text("Bamenda Reginal Hospital", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: const [
                              Icon(Icons.mail),
                              FittedBox(
                                child: Text(':  earlmillen7', style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: const [
                              Icon(Icons.link),
                              FittedBox(
                                child: Text(': Click to Visit', style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),),
                              )
                            ],
                          ),
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.white,
                              ),
                              onPressed: (){},
                              child: const Text('View Services Offered', style: TextStyle(color: Colors.indigo),)
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: 177.0,
                          height: 177.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Colors.indigo, width: 2.0)
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              Container(
                                child: const Icon(Icons.location_on_outlined, color: Colors.white,),

                              ),
                              Container(
                                child: const Text('View Location on map'),

                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 390.0,
              height: 235.0,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(15.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue, Colors.blueAccent, Colors.white]
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.indigo, width: 2.0)
              ),
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 177.0,
                    child: Column(
                      children: [
                        FittedBox(
                          child: Container(
                            width: 170,
                            child: const Text("Bamenda Reginal Hospital", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: const [
                              Icon(Icons.mail),
                              FittedBox(
                                child: Text(':  earlmillen7', style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: const [
                              Icon(Icons.link),
                              FittedBox(
                                child: Text(': Click to Visit', style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),),
                              )
                            ],
                          ),
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.white,
                              ),
                              onPressed: (){},
                              child: const Text('View Services Offered', style: TextStyle(color: Colors.indigo),)
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: 177.0,
                          height: 177.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Colors.indigo, width: 2.0)
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              Container(
                                child: const Icon(Icons.location_on_outlined, color: Colors.white,),

                              ),
                              Container(
                                child: const Text('View Location on map'),

                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 390.0,
              height: 235.0,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(15.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue, Colors.blueAccent, Colors.white]
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.indigo, width: 2.0)
              ),
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 177.0,
                    child: Column(
                      children: [
                        FittedBox(
                          child: Container(
                            width: 170,
                            child: const Text("Bamenda Reginal Hospital", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: const [
                              Icon(Icons.mail),
                              FittedBox(
                                child: Text(':  earlmillen7', style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: const [
                              Icon(Icons.link),
                              FittedBox(
                                child: Text(': Click to Visit', style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),),
                              )
                            ],
                          ),
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.white,
                              ),
                              onPressed: (){},
                              child: const Text('View Services Offered', style: TextStyle(color: Colors.indigo),)
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: 177.0,
                          height: 177.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Colors.indigo, width: 2.0)
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              Container(
                                child: const Icon(Icons.location_on_outlined, color: Colors.white,),

                              ),
                              Container(
                                child: const Text('View Location on map'),

                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 390.0,
              height: 235.0,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(15.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue, Colors.blueAccent, Colors.white]
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.indigo, width: 2.0)
              ),
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 177.0,
                    child: Column(
                      children: [
                        FittedBox(
                          child: Container(
                            width: 170,
                            child: const Text("Bamenda Reginal Hospital", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: const [
                              Icon(Icons.mail),
                              FittedBox(
                                child: Text(':  earlmillen7', style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: const [
                              Icon(Icons.link),
                              FittedBox(
                                child: Text(': Click to Visit', style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),),
                              )
                            ],
                          ),
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.white,
                              ),
                              onPressed: (){},
                              child: const Text('View Services Offered', style: TextStyle(color: Colors.indigo),)
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: 177.0,
                          height: 177.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Colors.indigo, width: 2.0)
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              Container(
                                child: const Icon(Icons.location_on_outlined, color: Colors.white,),

                              ),
                              Container(
                                child: const Text('View Location on map'),

                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
