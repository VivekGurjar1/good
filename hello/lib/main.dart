import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hello/firstpage.dart';

import 'package:hello/service.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> initializeApp=Firebase.initializeApp();
  final currentLocation=GeoLocatorService();

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (context)=>currentLocation.getLocatioon(),
      initialData: null,
      child: FutureBuilder(
        future:initializeApp ,
          builder: (context,snapShot){
        if(snapShot.hasError){
          print("Something went wrong");
        }
        if(snapShot.connectionState==ConnectionState.done){
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(

              primarySwatch: Colors.blue,
            ),
            home:FirstPage(),
          );
        }
        return CircularProgressIndicator();
      }),
    );
  }
}


