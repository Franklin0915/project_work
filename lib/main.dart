import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vehicle_recognition/Utils/di.dart';
import 'package:vehicle_recognition/api/result_model.dart';
import 'package:vehicle_recognition/onboarding_1.dart';
import 'package:vehicle_recognition/results.dart';

void main() {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Injector.registerDependencies();
  } catch (e) {
    debugPrint(e.toString());
  }

  runApp( 
  //   ResultsPage(
  //   result :CarModel(
  //   color: "red",
  //   id: "id",
  //   name: "name",
  //   numberPlate:  "numberPlate",
  //   ownerFullName:  "ownerFullName",
  //   registeredAt:  "registeredAt",
  // ),),
  const VehicleRecognition()
  );
}
