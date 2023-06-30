import 'package:flutter/material.dart';
import 'package:vehicle_recognition/onboarding.dart';


void main() {
  runApp(const VehicleRecognition());
}

class VehicleRecognition extends StatelessWidget {
  const VehicleRecognition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Onboarding(),
    );
  }
}
