import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hello/service.dart';
import 'package:hello/takingslots/TakingSlots.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  Set<Marker> _marker={};
  BitmapDescriptor mapMarker=BitmapDescriptor.defaultMarker;

  CollectionReference parkingProvider = FirebaseFirestore.instance.collection('Parkingprovider');

  @override
  void initState() {
    getData();

    setCustomMarker();

    super.initState();
  }
void setCustomMarker()async{

    // mapMarker= await BitmapDescriptor.fromAssetImage(ImageConfiguration(),'assets/picon.png');
    setState(() {

    });
    }
  void _onMapCreated(GoogleMapController controller)
  async{
    QuerySnapshot querySnapshot = await parkingProvider.get();
    print(querySnapshot.size);

    setState(() {

     querySnapshot.docs.forEach((doc) async {

       DocumentSnapshot documentSnapshot = await  parkingProvider.doc(doc.id).get();
       if (documentSnapshot.exists) {

         String uid = doc.id;
         String lat = documentSnapshot['lat'];
         String long = documentSnapshot['long'];
         print(lat);
         print(long);

         double lat1=double.parse(lat);
         double long1=double.parse(long);


         _marker.add(


           Marker(markerId:MarkerId(uid),position: LatLng(lat1,long1),
               infoWindow: InfoWindow(title: "Parking Slots",snippet: "Slots: ${documentSnapshot['availabeSlots']} Cost: ₹${documentSnapshot['costPerSlot']} per slot"
               ,onTap: (){
                 print("================$uid");
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>TakingSlots(id: uid,)));

                   }
               ),
               icon:BitmapDescriptor.defaultMarker
           ),


         );


       }
     });

   });

  }
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: Column(
          children: [
            Container(
              height: 280,
              child: currentPosition.longitude != null
                  ? GoogleMap(
    onMapCreated: _onMapCreated,
                markers: _marker,
                      initialCameraPosition:
                          CameraPosition(target: LatLng(currentPosition.latitude, currentPosition.longitude), zoom: 16),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      compassEnabled: true,
                      indoorViewEnabled: true,
                      mapToolbarEnabled: true,
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),

            Container(

              margin:EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                
                border: Border.all(color: Colors.black,width: 1.2),
                boxShadow: [
                  BoxShadow(offset:Offset(0,1),blurRadius: 10,
                  color: Colors.black.withOpacity(0.3))
                ]
                    
                
              ),
              child: ListTile(
                title: Container(

                  child: Text("Looking for Parking  "),

                ),
                trailing: IconButton(onPressed: (){
                  setState(() {

                  });
                }, icon:Image.asset("assets/picon.png")),
              ),
            ),



          ],
        ));
  }

  void getData() async

  {

  }
}

