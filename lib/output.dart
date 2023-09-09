// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'input.dart';

class OutputPage extends StatelessWidget {
  dynamic jsonReponse;
  late String title;
  late String desc;
  late String city;
  OutputPage({required this.jsonReponse}) {
    city = jsonReponse['name'];
    title = jsonReponse['weather'][0]['main'];
    desc = jsonReponse['weather'][0]['description'];
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
                children: [
                  Text(city),
                  Text(title),
                  Text(desc),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push( MaterialPageRoute(
                                  builder: (context) => InputPage()
                                ));
                        
                      },
                      child: Text("Click"))
                ],
              ),
            )));
  }
}
