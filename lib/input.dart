// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'weather_cal.dart';
import 'loading.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'output.dart';

Weather wt = Weather();


class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  late double long;
  late double lat;
  String city = "";

  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    return position;
  }

  void location() async {
    Position position = await getLocation();
    long = position.longitude;
    lat = position.latitude;
    if (city != "") {
      Response res = await wt.getDataOfCity(city);
      var jsonResp = jsonDecode(res.body);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OutputPage(
            jsonReponse: jsonResp,
          ),
        ),
      );

     
    } else {
      Response res = await wt.getData(long, lat);
      var jsonResp = jsonDecode(res.body);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OutputPage(
            jsonReponse: jsonResp,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text("WeatherApp"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a search term',
                    ),
                    onChanged: (value) {
                      city = value;
                    },
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: TextButton(
                          onPressed: () {
                            location();
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.black),
                          child: Text(
                            "Get Weather",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          )))
                ],
        )),
      ),
    );
  }
}
