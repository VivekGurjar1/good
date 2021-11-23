import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

class FinalRouteShow extends StatefulWidget {

  final String? lat;
  final String? long;
  FinalRouteShow({this.lat,this.long});

  @override
  _FinalRouteShowState createState() => _FinalRouteShowState();
}

class _FinalRouteShowState extends State<FinalRouteShow> {
  late GoogleMapController mapController1;
  BitmapDescriptor mapMarker=BitmapDescriptor.defaultMarker;


  Set<Marker> _marker={};
  @override
  void initState() {
    getBytesFromAsset('assets/m.png', 120).then((onValue) {
      mapMarker =BitmapDescriptor.fromBytes(onValue);

    });
    // setCustomMarker();
    // TODO: implement initState
    super.initState();
  }
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }  void _onMapCreated(GoogleMapController controller1)
  async{
    mapController1 = controller1;

    setState(() {


          _marker.add(


            Marker(markerId:MarkerId(widget.lat.toString()),position: LatLng(double.parse(widget.lat!),double.parse(widget.long!)),
                infoWindow: InfoWindow(title: "Your Destination",snippet: "For Route click on right corner "
                    ,onTap: (){



                    }

                ),
                icon:mapMarker
            ),);




    });

  }
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*.8,
            child:currentPosition.longitude != null?GoogleMap(

              onMapCreated: _onMapCreated,
              markers: _marker,
              initialCameraPosition:
              CameraPosition(target: LatLng(currentPosition.latitude, currentPosition.longitude), zoom: 16),

              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              indoorViewEnabled: true,
              mapToolbarEnabled: true,
            ):Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Container(
            child: ElevatedButton(onPressed: (){
              mapController1.animateCamera(CameraUpdate.newLatLng(LatLng(double.parse(widget.lat!),double.parse(widget.long!))));

              setState(() {

              });
            }, child: Text("Show My Destination")),
          )
        ],
      ),
    );
  }
}
