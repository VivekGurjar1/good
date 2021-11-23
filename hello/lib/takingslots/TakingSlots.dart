import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello/finalrouteshow/finalrouteshow.dart';
import 'package:hello/service.dart';
import 'package:hello/upipayment/upipayment.dart';

class TakingSlots extends StatefulWidget {
  final String? id;

  TakingSlots({this.id});

  @override
  _TakingSlotsState createState() => _TakingSlotsState();
}

class _TakingSlotsState extends State<TakingSlots> {

  String? lat;
  String? long;
  List<ModelForSlotsValues> slotviewer = [];
  CollectionReference parkingProvider = FirebaseFirestore.instance.collection('Parkingprovider');

  @override
  void initState() {
    GeoLocatorService.id = widget.id ?? "";

    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slot Booking"),
      ),
      body: slotviewer == null
          ? CircularProgressIndicator()
          : Container(
              height: 600,
              child: Column(
                children: [
                  Container(
                    height: 500,
                    child: GridView.builder(
                      padding: EdgeInsets.all(20),
                      itemCount: slotviewer.length,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          onTap: () {
                            if (slotviewer[index].availabel!) {
                              slotviewer[index].availabel = false;
                              slotviewer[index].test=true;
                            } else if(!slotviewer[index].availabel!&&slotviewer[index].test!){
                              slotviewer[index].availabel = true;
                            }
                            else if(!slotviewer[index].availabel!&&!slotviewer[index].test!)
                              {slotviewer[index].availabel=false;
                                
                              }


                            setState(() {});
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(

                                border: Border.all(
                              color:slotviewer[index].availabel!? Colors.black : !slotviewer[index].availabel!&&slotviewer[index].test!?Colors.green:Colors.red,width: 3.5
                            )),
                            child: new Card(
                              child: new GridTile(
                                footer: new Container(
                                  width: 160,
                                  height: 130,
                                  child: Icon(Icons.directions_car_filled_outlined,size: 100,color:slotviewer[index].availabel!? Colors.black : !slotviewer[index].availabel!&&slotviewer[index].test!?Colors.green:Colors.red, )//Image.asset("assets/l.jpg",fit: BoxFit.cover,),
                                ),
                                child: new Container(
                                  color: Colors.white,
                                  child: Text(slotviewer[index].slotName!),
                                ), //just for testing, will fill with image later
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        DocumentSnapshot documentSnapshot = await parkingProvider.doc(widget.id).get();




                        List<Map<String, dynamic>> s = [];

                        for (int i = 0; i < slotviewer.length; i++) {
                          s.add({"var": slotviewer[i].availabel, "var1": slotviewer[i].slotName});
                        }

                        await parkingProvider.doc(GeoLocatorService.id).update({"slotsName": s});





                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FinalRouteShow(lat: lat,long: long,)));

                      },
                      child: Text("Booking"))
                ],
              ),
            ),
    );
  }

  void getData() async {
    DocumentSnapshot documentSnapshot = await parkingProvider.doc(GeoLocatorService.id).get();

    if (documentSnapshot.exists) {
      List<dynamic> slot = await documentSnapshot['slotsName'];

      slot.forEach((element) {
        Map<String, dynamic> slot1 = element;
        ModelForSlotsValues modelForSlotsValues = ModelForSlotsValues(availabel: slot1['var'], slotName: slot1['var1'],test: slot1['var'] );
        slotviewer.add(modelForSlotsValues);
      });

      lat=await documentSnapshot['lat'];
      long=await documentSnapshot['long'];

      print(slotviewer.length);
    }
    setState(() {});
  }
}

class ModelForSlotsValues {
  String? slotName;
  bool? availabel;
  bool? test;

  ModelForSlotsValues({this.slotName, this.availabel,this.test});
}

class ModelForSlots {}
