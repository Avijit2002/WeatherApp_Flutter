import 'package:flutter/material.dart';
import 'weatherpage.dart';

class Cityselect extends StatefulWidget {
  const Cityselect({Key? key}) : super(key: key);

  @override
  State<Cityselect> createState() => _CityselectState();
}

class _CityselectState extends State<Cityselect> {
  late String location;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          //color: Colors.red,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/weather_app2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 25),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Icon(
                        Icons.location_city,
                        color: Colors.grey[800],
                        size: 150,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
                  child: TextField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (data) {
                      location = data;
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter Location',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                          Navigator.pop(context,location);  // we can pass data backward to previous screen
                      },
                      child: Text(
                        'GET WEATHER',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
