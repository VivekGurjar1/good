import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocatorService
{
  Future<Position> getLocatioon()async {
    var geolocator = Geolocator();
    return await geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high,locationPermissionLevel: GeolocationPermission.location);
  }
}

class Constraint {
  static User? user;

}