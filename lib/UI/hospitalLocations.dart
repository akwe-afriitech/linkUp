import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class hospitalLocations extends StatelessWidget {
  const hospitalLocations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> hospital = FirebaseFirestore.instance.collection('hospitals').snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital Services'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: 395,
              margin: const EdgeInsets.all(10),
              height: 650,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40.0)),
              child: StreamBuilder<QuerySnapshot>(
                stream: hospital,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("error loading data");
                  }
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Text("loading.....");
                  }
                  final data1 = snapshot.requireData;
                  return ListView.builder(
                    itemCount: data1.size,
                    itemBuilder: (context, index){
                      return ListTile(
                        tileColor: Colors.grey[100],
                        title: Text("Location: ${data1.docs[index]['location']} "),
                        subtitle: Text("Hospital: ${data1.docs[index]['name']} "),
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder:
                          //     (context)=> const Maps(),
                          // ));
                        },
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
