import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello/screen1.dart';

class CrossCheck extends StatefulWidget {
  const CrossCheck({Key? key}) : super(key: key);

  @override
  _CrossCheckState createState() => _CrossCheckState();
}

class _CrossCheckState extends State<CrossCheck> {

  String householderController="";
  String availabelSlots ="";
  String contactNo ="";
  String costPerSlot ="";
  String timing ="";
  String adharCard ="";
  String areaPinCode ="";
  String landmark ="";
  final _auth = FirebaseAuth.instance;
  CollectionReference parkingProvider =
  FirebaseFirestore.instance.collection('Parkingprovider');
  
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override

  
  
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              height: 40,width: 320,

              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(40)

              ),

              margin: EdgeInsets.all(20),
              child: Center(child: Text("Please Check Your Details",style: TextStyle(color:Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
            ),

                Row(
                  children: [
                    Container(
                      width:
                      180,

                      child: Column(
                        children: [
                          Text("HouseHolder Name    "),
                          SizedBox(height: 15,),
                          Text("Available           "),
                          SizedBox(height: 15,),
                          Text("Contact No          "),
                          SizedBox(height: 15,),
                          Text("Cost per Slot       "),
                          SizedBox(height: 15,),
                          Text("Timing              "),
                          SizedBox(height: 15,),
                          Text("Adhar Car No        "),
                          SizedBox(height: 15,),
                          Text("Area pin Code    "),
                          SizedBox(height: 15,),
                          Text("LandMark           "),
                        ],
                      ),
                    ),
                    Container(
width: 10,
                      child: Column(
                        children: [
                          Text(":"),
                          SizedBox(height: 15,),
                          Text(":"),
                          SizedBox(height: 15,),
                          Text(":"),
                          SizedBox(height: 15,),
                          Text(":"),
                          SizedBox(height: 15,),
                          Text(":"),
                          SizedBox(height: 15,),
                          Text(":"),
                          SizedBox(height: 15,),
                          Text(":"),
                          SizedBox(height: 15,),
                          Text(":"),
                        ],
                      ),
                    ),Container(

                      child: Column(
                        children: [
                          Text("    $householderController"),
                          SizedBox(height: 15,),
                          Text("$availabelSlots"),
                          SizedBox(height: 15,),
                          Text("$contactNo"),
                          SizedBox(height: 15,),
                          Text("$costPerSlot"),
                          SizedBox(height: 15,),
                          Text("$timing"),
                          SizedBox(height: 15,),
                          Text("$adharCard"),
                          SizedBox(height: 15,),
                          Text("$areaPinCode"),
                          SizedBox(height: 15,),
                          Text("$landmark"),
                        ],
                      ),
                    ),
                  ],
                ),


            Center(
              child: ElevatedButton(onPressed: ()async {
                 Navigator.popUntil(context, (route) => false);
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstScreen()));

              }, child: Text("Goto to User Mode")),
            )

          ],
        ),

      ),

    );
  }

  void getData() async{
    User user = _auth.currentUser!;

    DocumentSnapshot variable = await parkingProvider.doc(user.uid).get();

    householderController = variable['houseHolderName'];
    availabelSlots = variable['availabeSlots'];
    contactNo = variable['contactNo'];
    costPerSlot = variable['costPerSlot'];
    timing = variable['timing'];
    adharCard = variable['adharCardNo'];
    areaPinCode = variable['areaPinCode'];
    landmark = variable['landmark'];

    print(variable['lat']);
    print(variable['long']);

    setState(() {

    });
  }
}
