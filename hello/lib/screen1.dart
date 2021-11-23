import 'dart:typed_data';
import 'dart:ui' as ui;

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

    getBytesFromAsset('assets/m.png', 120).then((onValue) {
      mapMarker =BitmapDescriptor.fromBytes(onValue);

    });
    setCustomMarker();



    super.initState();
  }
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
void setCustomMarker()async{

     // mapMarker= await BitmapDescriptor.fromAssetImage(ImageConfiguration(),'assets/l.jpg');
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
               icon:mapMarker
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





          ],
        ),
    bottomNavigationBar: ElevatedButton(onPressed: (){ setState(() {

    });}, child: Text("Get The Parking Locations")
    ,
    style: ElevatedButton.styleFrom(primary: Colors.indigoAccent),),
    );
  }


}

