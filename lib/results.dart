import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vehicle_recognition/api/result_model.dart';

import 'Utils/assets.dart';

class ResultsPage extends StatelessWidget {
  final ResultModel result;

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
              top: MediaQuery.of(context).size.height * 0.3,
              left: 0,
              right: 0,
              child: SizedBox(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name:${result.ownerFullName}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Age:${result.ownersAge}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Nationality:${result.ownersNationality}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Identification:${result.nationalIdentification}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Gender:${result.ownerGender}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                             CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.amber,
                              child: Image.network("http://192.168.24.119:8000${result.driversImage}"),
                            )
                          ],
                        ),
                        const SizedBox(height: 100),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Brand:${result.vehicleBrand}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Model:${result.model}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Number Plate:${result.numberPlate}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Color of car:${result.color}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Registered at:${result.registeredAt}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Vehicle Category:${result.vehicleCategory}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Registered:${result.registered}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Chasis Number:${result.chasisNumber}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Registration Expiry:${result.registrationExpiry}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                             CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.amber,
                              child: Image.network("http://localhost:8000/${result.carsImage}"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
// "plate_number": "KAK825",
// "owner_fullname": "Samuel Tweneboah",
// "registered_at": "Bono Region",
// "id": 1,
// "Vehicle_brand": null,
// "Vehicle_model": null,
// "color": "Ash",
// "drivers_image": null,
// "cars_image": null,
// "owner_gender": null,
// "Registered": false,
// "owners_nationality": null,
// "owners_age": null,
// "registration_expiry": null,
// "vehicle_category": null,
// "chasis_number": null,
// "national_identification": null