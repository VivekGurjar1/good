import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hello/crosscheck/crosscheck.dart';



class ProviderDetails extends StatefulWidget {
  const ProviderDetails({Key? key}) : super(key: key);

  @override
  _ProviderDetailsState createState() => _ProviderDetailsState();
}

class _ProviderDetailsState extends State<ProviderDetails> {
  double lat=0.0;
  double long=0.0;

  String name="";
  bool checkForLocation=false;

  CollectionReference parkingProvider =
  FirebaseFirestore.instance.collection('Parkingprovider');
  CollectionReference parking =
    FirebaseFirestore.instance.collection('parking');
  final _auth = FirebaseAuth.instance;

  TextEditingController householderController =TextEditingController();
  TextEditingController availabelSlots =TextEditingController();
  TextEditingController contactNo =TextEditingController();
  TextEditingController costPerSlot =TextEditingController();
  TextEditingController timing =TextEditingController();
  TextEditingController adharCard =TextEditingController();
  TextEditingController areaPinCode =TextEditingController();
  TextEditingController landmark =TextEditingController();
  
  @override
  void initState() {
    getdata();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Important Details"),
      ),

      body: SingleChildScrollView(
        child: Container(

          child: Column(
            children: [
              Container(
                height: 40,width: 320,
                
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(40)
                  
                ),

                margin: EdgeInsets.all(20),
                child: Center(child: Text("Hello, Mr."+name.toUpperCase()+ ", Hope ,you are good!",style: TextStyle(color:Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40)
                ),
                margin: EdgeInsets.only(left: 20,top: 7,right: 20,bottom: 7),
                child: TextFormField(

                  controller: householderController,
                  obscureText: false,
                  decoration:InputDecoration(
                    contentPadding: EdgeInsets.only(top: 5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)
                      ),
                      prefixIcon: Icon(Icons.house,size: 22,),
                      hintText:"HouseHolder Nane"

                  ),

                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40)
                ),
                margin: EdgeInsets.only(left: 20,top: 7,right: 20,bottom: 7),
                child: TextFormField(

                  controller: availabelSlots,
                  obscureText: false,
                  decoration:InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)
                      ),
                      prefixIcon: Icon(Icons.car_rental,size: 22,),
                      hintText:"Available Slots"

                  ),

                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40)
                ),
                margin: EdgeInsets.only(left: 20,top: 7,right: 20,bottom: 7),
                child: TextFormField(

                  controller: contactNo,
                  obscureText: false,
                  decoration:InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)
                      ),
                      prefixIcon: Icon(Icons.contact_phone,size: 22,),
                      hintText:"Contact No."

                  ),

                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40)
                ),
                margin: EdgeInsets.only(left: 20,top: 7,right: 20,bottom: 7),
                child: TextFormField(

                  controller: costPerSlot,
                  obscureText: false,
                  decoration:InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)
                      ),
                      prefixIcon: Icon(Icons.monetization_on_rounded,size: 22,),
                      hintText:"Cost per Slot."

                  ),

                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40)
                ),
                margin: EdgeInsets.only(left: 20,top: 7,right: 20,bottom: 7),
                child: TextFormField(

                  controller: timing,
                  obscureText: false,
                  decoration:InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)
                      ),
                      prefixIcon: Icon(Icons.timelapse_rounded,size: 22,),
                      hintText:"Timing."

                  ),

                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40)
                ),
                margin: EdgeInsets.only(left: 20,top: 7,right: 20,bottom: 7),
                child: TextFormField(

                  controller: adharCard,
                  obscureText: false,
                  decoration:InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)
                      ),
                      prefixIcon: Icon(Icons.airline_seat_recline_normal_sharp,size: 22,),
                      hintText:"AdharCard No."

                  ),

                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40)
                ),
                margin: EdgeInsets.only(left: 20,top: 7,right: 20,bottom: 7),
                child: TextFormField(

                  controller: areaPinCode,
                  obscureText: false,
                  decoration:InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)
                      ),
                      prefixIcon: Icon(Icons.airline_seat_recline_normal_sharp,size: 22,),
                      hintText:"Area Pin Code."

                  ),

                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40)
                ),
                margin: EdgeInsets.only(left: 20,top: 7,right: 20,bottom: 7),
                child: TextFormField(

                  controller: landmark,
                  obscureText: false,
                  decoration:InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)
                      ),
                      prefixIcon: Icon(Icons.airline_seat_recline_normal_sharp,size: 22,),
                      hintText:"LandMark."

                  ),

                ),
              ),

              Row(
                children: [
                  Checkbox(value: checkForLocation, onChanged: (l){
                    checkForLocation=l!;
                    
                    if(checkForLocation){

                      location();
                    }
                    setState(() {

                    });
                    
                  }),
                  Text("location is required for for verifying perfect  \n location and also for show the  location in google map",style: TextStyle(fontSize: 12),)
                  
                ],
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40)
                ),
                margin: EdgeInsets.only(left: 20,top: 7,right: 20,bottom: 7),
                child: ElevatedButton(
                  onPressed: (){
                    if(householderController.text==""||availabelSlots.text==""||contactNo.text==""||costPerSlot.text==""||timing.text==""||adharCard.text==""||areaPinCode.text==""||landmark.text==""||!checkForLocation)
                    {

                      Fluttertoast.showToast(msg: "plz fill required field",backgroundColor: Colors.red,textColor: Colors.white,gravity: ToastGravity.BOTTOM);

                    }
                    else
                      {
                        addProviderddata();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CrossCheck()));

                      }

                  },
                  child:Text("Submit")
                  ,)
              ),






            ],
          ),
        ),
      ),

    );
  }

  void addProviderddata() async{

    Map<String,dynamic> d={

    };List<Map<String,dynamic>> s=[
      {"var":true,
        "var1":"0"}
    ];






for(int i=1;i<int.parse(availabelSlots.text);i++)
  {
    s.add({"var":true,
      "var1":i.toString()});
  }




    User user=_auth.currentUser!;



    ProviderModel providerModel=ProviderModel();
    providerModel.houseHolderName=householderController.text;
    providerModel.availabeSlots=availabelSlots.text;
    providerModel.contactNo=contactNo.text;
    providerModel.costPerSlot=costPerSlot.text;
    providerModel.timing=timing.text;
    providerModel.adharCardNo=adharCard.text;
    providerModel.areaPinCode=areaPinCode.text;
    providerModel.landmark=landmark.text;
    providerModel.lat=lat.toString();
    providerModel.long=long.toString();
    providerModel.slotsName=s;

    print("vievk");


    try {



      await parkingProvider.doc(user.uid).set(providerModel.toMap());
    } on Exception catch (e) {
      print(e);
    }



  }

  void getdata() async{

    User user=_auth.currentUser!;

    DocumentSnapshot variable =await parking.doc(user.uid).get();

    name=variable['name'];

    print("name");

    setState(() {

    });
    

  }

  void location() async{


      var geolocator = Geolocator();
      Position position =await geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high,locationPermissionLevel: GeolocationPermission.location);
      lat=position.latitude;
      long=position.longitude;




  }
}
class ProviderModel {
  String? houseHolderName;
  String? availabeSlots;
  String? contactNo;
  String?  costPerSlot;
  String? timing;
  String? adharCardNo;
  String? areaPinCode;
  String? landmark;
  String? lat;
  String? long;
  List<Map<String,dynamic>>? slotsName;

  ProviderModel({this.houseHolderName, this.availabeSlots, this.contactNo, this.costPerSlot, this.timing, this.adharCardNo, this.areaPinCode, this.landmark, this.lat, this.long,this.slotsName  });

  factory ProviderModel.fromMap(map) {
    return ProviderModel(
        houseHolderName: map["houseHolderName"],
        availabeSlots: map["availabeSlots"],
        contactNo: map["contactNo"],
    costPerSlot: map["costPerSlot"],
        timing: map["timing"],
        adharCardNo: map["adharCardNo"],
        areaPinCode: map["areaPinCode"],
        landmark: map["landmark"],
        lat: map["lat"],
        long: map["long"],
        slotsName:map["slotsName"]


    );
  }

  Map<String, dynamic> toMap() {
    return {

      'houseHolderName': houseHolderName,
      'availabeSlots': availabeSlots,
      'contactNo': contactNo,
      'costPerSlot': costPerSlot,
      'timing':timing,
      'adharCardNo': adharCardNo,
      'areaPinCode': areaPinCode,
      'landmark': landmark,
      'lat': lat,
      'long': long,
      'slotsName':slotsName,

    };
  }
}


