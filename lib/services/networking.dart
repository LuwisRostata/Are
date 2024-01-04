
import 'package:test_clima_flutter/services/location.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Networking{
  late double temp, lon, lat;
  late int id;
  late String data, city, desc;

  void getWeatherData() async{
    Location loc = Location();
    await loc.getLocation();
    lon=loc.lon;
    lat=loc.lat;
    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=cc5f0621c9c4796b8f0683e23d26dadf&units=metric");
    Response response = await get(url);
    data = response.body;
    if (response.statusCode == 200){
      desc = jsonDecode(data)['weather'][0]['description'];
      temp = jsonDecode(data)['main']['temp'];
      id = jsonDecode(data)['id'];
      city = jsonDecode(data)['name'];
      print(lon);
      print(lat);
      print(city);
      print(desc);
      print(temp);
      print(id);
    }
  }

}