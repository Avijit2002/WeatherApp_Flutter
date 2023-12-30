import 'package:geolocator/geolocator.dart';

class Location{
  late double latitude;
  late double longitude;

  Future<void> getLocation() async{
    //LocationPermission permission = await Geolocator.requestPermission();
    //LocationPermission permission = await Geolocator.checkPermission();
    /*bool isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
    if(isLocationServiceEnabled )
      {
        print("yes");
      }
    else{
      print("no");
    }*/
    try{
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
        latitude = position.latitude;
        longitude = position.longitude;
        print(latitude);
        print(longitude);
    }
    catch(e){
      print(e);
    }
  }

}