import 'package:flutter/material.dart';
import 'package:linkup/UI/submitted.dart';
import 'package:multiselect/multiselect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class hospitals extends StatefulWidget {
  const hospitals({Key? key}) : super(key: key);

  @override
  State<hospitals> createState() => _hospitalsState();
}

class _hospitalsState extends State<hospitals> {
  var _hospitalName='';
  var _location='';
  var _extraFacilities='';
  var _extraServices='';
  var _email='';
  var _website='';
  List<String> _servicesChecked = [];
  List<String> _facilitiesChecked = [];


  final List<String> _services = ['Emergency care',
    'Impatient Care',
    'Outpatient Care',
    'Surgery',
    'Rehabilitation',
    'Laboratory Services',
    'Imaging Services',
    'Pharmacy',
    'Anesthesiology',
    'obstetrics',
    'gynecology',
    'Pediatrics',
    'oncology',
    'Psychiatry',
    'Neurology',
    'Cardiology',
    'Pulmonology',
    'Gastroenterology',
    'Nephrology',
    'Rheumatology',
    'Nutrition Services',
    'Social work',
    'Speech therapy'
  ];
  final List<String> _facilities = ['Operation Room',
    'Intensive Care Unit',
    'Neonatal Intensive care Unit',
    'Pediatrics Wing',
    'Gynaecology wing',
    'laboratory',
    'Oncology Unit',
    'Cardiology Unit',
    'Blood Bank',
    'Palliative care',
    'Social work department',
    'Nutrition services',
    'Speech therapy department',
    'Pharmacy',
    'Radiology',
    'Mental Health Wing',
    'Rehabilitation unit',
    'Physical therapy unit'


  ];

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Your Hospital Data"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value){
                    if(value!.length < 3)
                      return 'Please Enter A Name to Your Hospital';
                    else return null;
                  },
                  onChanged: (value){
                    _hospitalName = value;
                  },

                  decoration: const InputDecoration(
                      labelText: 'Hospital Name'
                  ),
                ),
                TextFormField(
                  onChanged: (value){
                    _location = value;
                  },
                  validator: (value){
                    if(value!.length < 3)
                      return 'Please Enter A Name to Your Hospital';
                    else return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Hospital Location'
                  ),
                ),
                TextFormField(
                  onChanged: (value){
                    _email = value;
                  },
                  validator: (value){
                    if(value!.length < 3)
                      return 'Please Enter A Name to Your Hospital';
                    else return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Hospital email'
                  ),
                ),
                TextFormField(
                  onChanged: (value){
                    _website = value;
                  },
                  validator: (value){
                    if(value!.length < 3)
                      return 'Please Enter A Name to Your Hospital';
                    else return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Hospital website'
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: DropDownMultiSelect(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    options: _services,
                    selectedValues: _servicesChecked,

                    onChanged: (value) {
                      print('selected services $value');
                      setState(() {
                        _servicesChecked = value;
                      });
                      print('you have selected $_servicesChecked services.');
                    },
                    whenEmpty: 'Select the services your hospital offers',
                  ),
                ),
                TextFormField(
                  onChanged: (value){
                    _extraServices = value;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Enter any other Hospital service you did not find on the checklist'
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: DropDownMultiSelect(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    options: _facilities,
                    selectedValues: _facilitiesChecked,
                    onChanged: (value) {
                      print('selected facilities $value');
                      setState(() {
                        _facilitiesChecked = value;
                      });
                      print('you have selected $_facilitiesChecked facilities.');
                    },

                    whenEmpty: 'Select the Facilities your hospital Has',
                  ),
                ),
                TextFormField(
                  onChanged: (value){
                    _extraFacilities = value;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Enter any other Hospital Facilities you did not find on the checklist'
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 40),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () async {

                        final isValid = formKey.currentState!.validate();
                        if(!isValid)return;
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(child: CircularProgressIndicator(),)
                        );
                        CollectionReference hospital = FirebaseFirestore.instance.collection('hospital');
                        hospital.add({
                          "name" : _hospitalName,
                          'facilities':_facilitiesChecked,
                          'servicesChecked':_servicesChecked,
                          'location': _location,
                          'email': _email,
                          'extraServices': _extraServices,
                          'extraFacilities': _extraFacilities,
                          'website': _website,
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context) => const submitted()
                            )
                        );
                      },
                      child: const Text('Submit')
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
