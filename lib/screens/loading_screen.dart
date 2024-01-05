import 'package:flutter/material.dart';
import 'package:test_clima_flutter/screens/location_screen.dart';
import 'package:test_clima_flutter/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('images/location_background.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
              ),
            ),
          child: SpinKitDoubleBounce(
            size: 70.0,
            color: Colors.white,
          )
        ),
      ),
    );
  }

  void getData() async{
    Networking net = Networking();
    String data= await net.getWeatherData();
    print(data);

    Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context){
      return LocationScreen(data);
    }));
  }

}
