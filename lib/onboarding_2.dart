import 'package:flutter/material.dart';

import "package:vehicle_recognition/Utils/assets.dart";
import 'package:vehicle_recognition/scan_page.dart';


class Onboarding2 extends StatelessWidget {
  const Onboarding2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
              image: DecorationImage(
                image: AssetImage(AssetNames.onboardingPage_1),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
              child: Container(
                color: Colors.purple[900]?.withOpacity(0.5),
                child: const Padding(
                  padding:  EdgeInsets.fromLTRB(20, 45, 20, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                          )
                        ],
                      ),
                       SizedBox(height: 50),
                       Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "VEHICLE \nNUMBER \nPLATE \nRECOGNITION",
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScanPage()),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.purple[900]),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: Text(
                "Start Scan",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
