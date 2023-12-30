import 'package:flutter/material.dart';
import 'location.dart';
import 'network.dart';
import 'loading_Screen.dart';
import 'citypage.dart';
import 'weathermodel.dart';

class Weatherpage extends StatefulWidget {
  Weatherpage({this.weatherdata}); // receiving data loading screen
  late var weatherdata;
  @override
  State<Weatherpage> createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {
  late int temp;
  late int id;
  late String city;
  late String location;

  @override
  void initState() {
    super.initState();

    //print(widget.weatherdata);// use widget to import weatherdata from stateful to state class
    updateUI(widget.weatherdata);

    //print(temp);
  }

  void updateUI(dynamic data) {
    // we crreated this function so that we can call it to extratct data and put it in variable
    //print(data);
    setState(() {
      temp = data['main']['temp'].toInt();
      id = data['weather'][0]['id'];
      city = data['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/weather_app.jfif'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Location currentL = Location();
                        await currentL
                            .getLocation(); // we can only await in methods that return future.
                        double latitude = currentL.latitude;
                        double longitude = currentL.longitude;
                        Network request = Network(
                          Uri(
                              //building netwirk object
                              scheme: 'https',
                              host: 'api.openweathermap.org',
                              path: '/data/2.5/weather',
                              queryParameters: {
                                'lat': '$latitude',
                                'lon': '$longitude',
                                'appid': apikey,
                                'units': 'metric'
                              }),
                        );
                        var weatherdata = await request.api();
                        updateUI(weatherdata);
                      },
                      child: Icon(
                        Icons.navigation,
                        color: Colors.grey[800],
                        size: 60,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        location = await Navigator.push(
                            context, // we can recive data from previous page
                            MaterialPageRoute(builder: (context) {
                          return Cityselect();
                        }));
                        if (location != null) {
                          Network request = Network(
                            Uri(
                                //building netwirk object
                                scheme: 'https',
                                host: 'api.openweathermap.org',
                                path: '/data/2.5/weather',
                                queryParameters: {
                                  'q': location,
                                  'appid': apikey,
                                  'units': 'metric'
                                }),
                          );
                          var weatherdata = await request.api();
                          //print(weatherdata);
                          updateUI(weatherdata);
                        }
                      },
                      child: Hero(
                        tag: 'logo',
                        child: Icon(
                          Icons.location_city,
                          color: Colors.grey[800],
                          size: 60,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                DefaultTextStyle(
                                  style: const TextStyle(
                                    fontSize: 50,
                                  ),
                                  child: Text(
                                    WeatherModel.getWeatherIcon(id),
                                  ),
                                ),
                                DefaultTextStyle(
                                  style: const TextStyle(
                                    fontSize: 140,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    temp.toString(),
                                  ),
                                ),
                                const DefaultTextStyle(
                                  style: TextStyle(
                                    fontSize: 60,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    '°C',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                DefaultTextStyle(
                                  style: const TextStyle(fontSize: 46),
                                  child: Text(city),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 0, left: 12),
                              child: DefaultTextStyle(
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                child: Text(
                                  WeatherModel.getMessage(temp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
