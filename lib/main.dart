import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vehicle_recognition/Utils/di.dart';
import 'package:vehicle_recognition/onboarding_1.dart';

void main() {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Injector.registerDependencies();
  } catch (e) {
    debugPrint(e.toString());
  }

  runApp(const VehicleRecognition());
}
