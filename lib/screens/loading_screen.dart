import 'package:flutter/material.dart';
import 'package:test_clima_flutter/services/networking.dart';

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
    Networking net = Networking();
    net.getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {

          },
          child: const Text('Get Location'),
        ),
      ),
    );
  }



}
