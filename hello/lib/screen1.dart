import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hello/service.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<Mmarker> _markerList = [];

  CollectionReference parkingProvider = FirebaseFirestore.instance.collection('Parkingprovider');

  @override
  void initState() {
    getData();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: Container(
          height: 280,
          child: currentPosition.longitude != null
              ? GoogleMap(
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
        ));
  }

  void getData() async {
    QuerySnapshot querySnapshot = await parkingProvider.get();

    print(querySnapshot.size);



    querySnapshot.docs.forEach((doc) async {
      print(doc.id);
      DocumentSnapshot documentSnapshot = await  parkingProvider.doc(doc.id).get();
      if (documentSnapshot.exists) {
        print(documentSnapshot);
        print(documentSnapshot['lat']);
        print(documentSnapshot['long']);
        print(doc.id);

        String uid = doc.id;
        String lat = documentSnapshot['lat'];
        String long = documentSnapshot['long'];
        // print(documentSnapshot);
        Mmarker m = Mmarker(id: doc.id, lat: lat, long: long);
        _markerList.add(m);
      }
    });

    print("markders-->${_markerList.length}");
  }
}

class Mmarker {
  String? lat;
  String? long;
  String? id;

  Mmarker({this.id, this.long, this.lat});
}
