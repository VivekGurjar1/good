import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello/service.dart';

class TakingSlots extends StatefulWidget {
  final String? id;
  TakingSlots({this.id});

  @override
  _TakingSlotsState createState() => _TakingSlotsState();
}

class _TakingSlotsState extends State<TakingSlots> {

  List<ModelForSlotsValues> slotviewer=[];
  CollectionReference parkingProvider = FirebaseFirestore.instance.collection('Parkingprovider');

  @override
  void initState() {
    GeoLocatorService.id=widget.id??"";

    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Slot Booking"),),
      body: slotviewer==null?CircularProgressIndicator():Container(
        height: 600,
        child:Column(children: [

          Container(
            height: 400,
            child: GridView.builder(
              padding: EdgeInsets.all(20)
              ,
              itemCount: slotviewer.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ),
              itemBuilder: (BuildContext context, index) {
                return InkWell(
                  onTap: (
                  ){

                    if(slotviewer[index].availabel!)
                      {

                    slotviewer[index].availabel=false;
                    }
                    else
                      slotviewer[index].availabel=true;

                    setState(() {

                    });
                  },
                  child: Container(height: 40,width: 40,
                    decoration: BoxDecoration(
                      border: Border.all( color:slotviewer[index].availabel!?Colors.black:Colors.red ,
                      )
                    ),

                    child: new Card(
                      child: new GridTile(
                        footer: new Container( child: Text(slotviewer[index].availabel.toString()),),
                        child: new Container( color:Colors.white,child: Text(slotviewer[index].slotName!),), //just for testing, will fill with image later
                      ),
                    ),
                  ),
                );
              },
            ),
          ),



          ElevatedButton(onPressed: ()async {

            DocumentSnapshot documentSnapshot = await  parkingProvider.doc(widget.id).get();

            List vars=[];
            List var1=[];
            slotviewer.forEach((element) {
              vars.add(element.availabel);
            });slotviewer.forEach((element) {
              var1.add(element.slotName);
            });
print(vars.length);
print(var1.length);
print(slotviewer.length);

            List yourItemList = [];

            for (int i = 0; i < slotviewer.length; i++)
              yourItemList.add({
                "var": vars.toList()[i],
                "var1":var1.toList()[i]

              });
            List<Map<String,dynamic>> s=[

            ];

            for(int i=0;i<slotviewer.length;i++)
            {
              s.add({"var":slotviewer[i].availabel,
                "var1":slotviewer[i].slotName});
            }



                          await parkingProvider
                              .doc(GeoLocatorService.id)
                              .update({
                           "slotsName":s

                          });

                      },

              child: Text("Booking"))

        ],)
        ,
      ),
    );
  }

  void getData() async{

    DocumentSnapshot documentSnapshot = await  parkingProvider.doc(GeoLocatorService.id).get();

    if (documentSnapshot.exists) {


      List<dynamic> slot = await documentSnapshot['slotsName'];

      slot.forEach((element) {
        Map<String,dynamic> slot1=element;
        ModelForSlotsValues modelForSlotsValues=ModelForSlotsValues(availabel: slot1['var'],slotName: slot1['var1']);
        slotviewer.add(modelForSlotsValues);

      });




      print(slotviewer.length);





    }
setState(() {

});

  }
}

class ModelForSlotsValues{
  
  String? slotName;
  bool? availabel;
  
  ModelForSlotsValues({this.slotName,this.availabel});
  
}
class ModelForSlots{

}

