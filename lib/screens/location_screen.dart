import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_clima_flutter/screens/city_screen.dart';
import 'package:test_clima_flutter/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.data, {super.key});
  String data;
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel WM= new WeatherModel();
  late double temp;
  late int id;
  late String city, desc,
      TempT = '', TempIC = '', CityText = '';
  String? NewCity = null, info = null;

  @override
  void initState() {
    super.initState();
    info=widget.data;
    UpdateWeath();
    UpdateUI();
  }

  void UpdateWeath(){
    desc = jsonDecode(info.toString())['weather'][0]['description'];
    temp = jsonDecode(info.toString())['main']['temp'];
    id = jsonDecode(info.toString())['weather'][0]['id'];
    city = jsonDecode(info.toString())['name'];
  }
  void UpdateUI(){
    try{
      UpdateWeath();
      TempT = temp.toStringAsFixed(0) + '°';
      TempIC = WM.getWeatherIcon(id);
      CityText = WM.getMessage(temp.toInt())+"\n$city!";
    }
    catch(e){
      // Handle the case where program can't get weather info
      TempT = 'ERROR';
      TempIC = '8';
      CityText = "Couldn't find weather info";
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  children: <Widget>[
                    Image(
                      image: AssetImage('images/$TempIC.png'),
                      width: 250,
                      height: 250,
                    ),
                    Text(
                      TempT,
                      style: TextStyle(fontSize: 50),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  CityText,
                  textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                ),
              ),Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        info=widget.data;
                        UpdateUI();
                      });
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                        color: Colors.white
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      NewCity= await Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      setState(() {
                        info= NewCity;
                        UpdateUI();
                      });
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
