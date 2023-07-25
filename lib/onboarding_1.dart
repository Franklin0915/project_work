import 'package:flutter/material.dart';
import 'package:vehicle_recognition/Utils/assets.dart';
import 'package:vehicle_recognition/api/plate_recognition_usecase.dart';
import 'package:vehicle_recognition/onboarding_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Utils/di.dart';
import 'bloc/recognize_plate_bloc.dart';

class VehicleRecognition extends StatelessWidget {
  const VehicleRecognition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RecognizePlateBloc(Injector.getIt.get<RecognizePlate>()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Onboarding1(),
      ),
    );
  }
}

class Onboarding1 extends StatefulWidget {
  const Onboarding1({Key? key}) : super(key: key);

  @override
  State<Onboarding1> createState() => _Onboarding1State();
}

class _Onboarding1State extends State<Onboarding1> with TickerProviderStateMixin {
  double _height = 50;
  double _width = 50;
  late AnimationController _motionController;
  late Animation _motionAnimation;

  @override
  void initState() {
    super.initState();
    _motionController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      lowerBound: 0.5,
    );

    _motionAnimation = CurvedAnimation(
      parent: _motionController,
      curve: Curves.ease,
    );

    _motionController.forward();
    _motionController.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed) {
          _motionController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _motionController.forward();
        }
      });
    });

    _motionController.forward();
    _motionController.addListener(() {
      setState(() {
        _height = _motionController.value * 100;
        _width = _motionController.value * 100;
      });
    });
    _motionController.repeat();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const Onboarding2()),
        (route) => false,
      );
    });
  }

  @override
  void dispose() {
    _motionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[900]?.withOpacity(0.6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AssetNames.car_img, height: _height, width: _width),
            const Text(
              "NUMBER PLATE\n RECONITION",
              style: TextStyle(fontSize: 19, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
