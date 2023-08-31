import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vehicle_recognition/api/car_model.dart';

import 'Utils/assets.dart';

class ResultsPage extends StatelessWidget {
  final CarModel result;

  const ResultsPage({required this.result, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Container(
              width: double.infinity,
              color: HexColor("#573A9F"),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(AssetNames.car_img, height: 50, width: 80),
                      const Text(
                        "NUMBER PLATE\n RECOGNITION",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ), // First color
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Container(
              color: Colors.white,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Container(
              color: HexColor("#573A9F"),
              child: const Align(
                alignment: Alignment.topRight,
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.19,
              left: (MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width * 0.7) /
                  2,
              child: Container(
                color: HexColor("#573A9F"),
                width: MediaQuery.of(context).size.width * 0.7,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text("RESULTS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center),
                ),
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: (MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width * 0.7) /
                  2,
              right: (MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width * 0.7) /
                  2,
              child: SizedBox(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Car Name:${result.name}",
                        style: const TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.none,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Owned by:${result.ownerFullName}",
                        style: const TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.none,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Number Plate:${result.numberPlate}",
                        style: const TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.none,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Color of car:${result.color}",
                        style: const TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.none,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Registered at:${result.registeredAt}",
                        style: const TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.none,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
