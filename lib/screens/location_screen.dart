import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test_clima_flutter/screens/city_screen.dart';
import 'package:test_clima_flutter/utilities/constants.dart';
import 'package:test_clima_flutter/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.data, {super.key});
  String data;
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late double temp;
  late int id;
  late String city, desc, info='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    info=widget.data;
    UpdateUI();
  }

  void UpdateUI(){
    desc = jsonDecode(info)['weather'][0]['description'];
    temp = jsonDecode(info)['main']['temp'];
    id = jsonDecode(info)['weather'][0]['id'];
    city = jsonDecode(info)['name'];

    print(city);
    print(desc);
    print(temp);
    print(id);
  }
  @override
  Widget build(BuildContext context) {
    WeatherModel WM= new WeatherModel();
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
              Row(
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
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      String NewCity;
                      NewCity= await Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      Uri url1 = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$NewCity&appid=cc5f0621c9c4796b8f0683e23d26dadf&units=metric");
                      Response resp = await get(url1);
                      setState(() {
                        info= resp.body;
                        UpdateUI();
                      });
                      print(NewCity);
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temp.toStringAsFixed(0) + '°',
                      style: TextStyle(fontSize: 50),
                    ),
                    Text(
                      WM.getWeatherIcon(id),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  WM.getMessage(temp.toInt())+" $city!",
                  textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
