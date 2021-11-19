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

  @override
  void initState() {



    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    final currentPosition=Provider.of<Position>(context);
    return Scaffold(
    appBar: AppBar(
      title: Text("Details"),
    ),
      body:Container(
        height: 280,
        child: currentPosition.longitude!=null?GoogleMap(


          initialCameraPosition: CameraPosition(target: LatLng(currentPosition.longitude,currentPosition.longitude),zoom: 16),



          myLocationEnabled: true,

          myLocationButtonEnabled: true,compassEnabled: true,
          indoorViewEnabled: true,
 mapToolbarEnabled: true,
        ):Center(child: CircularProgressIndicator(),),
      )


    );
  }
}
