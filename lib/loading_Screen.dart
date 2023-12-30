import 'package:flutter/material.dart';
import 'location.dart';
import 'weatherpage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'network.dart';

const String apikey = '8de34cb9b78134d6a07fd921d97425a8';

class Loadingscreen extends StatefulWidget {
  const Loadingscreen({Key? key}) : super(key: key);

  @override
  State<Loadingscreen> createState() => _LoadingscreenState();
}

class _LoadingscreenState extends State<Loadingscreen> {

  late double latitude;
  late double longitude;


  void getLocationdata() async{
    Location currentL = Location();
    await currentL.getLocation();   // we can only await in methods that return future.
    latitude=currentL.latitude;
    longitude=currentL.longitude;
    print(latitude);
    Network request = Network(Uri(   //building netwirk object
        scheme: 'https',
        host: 'api.openweathermap.org',
        path: '/data/2.5/weather',
        queryParameters: {'lat': '$latitude' ,'lon':'$longitude'  ,'appid': apikey ,'units': 'metric'}
    ),);
    var weatherdata = await request.api();  // calling network object
    print(weatherdata);
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return Weatherpage(weatherdata:weatherdata);  //sending data to weatherpage
    }));

  }

  /*void api() async
  {
    //print(response.body); // prints the data fetched
    //print(response.statusCode); // prints the code ... if 200 then ok...if 400 or 500 then error
  }*/

  @override
  void initState(){    //used to get location automatically on app start
    super.initState();
    getLocationdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/weather_app3.jpg'),
              fit: BoxFit.cover,
            ),
          ) ,
          child: Center(
            child: SpinKitRipple(
              color: Colors.purple,
              size: 180,
            ),
          ),
        ),
      ),
    );
  }
}
