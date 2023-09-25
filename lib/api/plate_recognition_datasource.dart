import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_recognition/Utils/errors.dart';
import 'package:vehicle_recognition/Utils/network.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_recognition/api/result_model.dart';
import '../Utils/constants.dart';
import '../Utils/network_v2.dart';
import 'dart:convert';

abstract class RecognizePlateRemoteDatasource {
  Future<ResultModel> recognizePlate(XFile imageFile);
}

class RecognizePlateRemoteDatasourceImpl
    implements RecognizePlateRemoteDatasource {
  final NetworkService _networkService;

  RecognizePlateRemoteDatasourceImpl(this._networkService);

  @override
  Future<ResultModel> recognizePlate(imageFile) async {
    try {
      // Replace 'your_api_endpoint' with the actual API endpoint
      var url = Uri.parse(kBaseUrl);

      // Create a multipart request
      var request = http.MultipartRequest('POST', url);

      // Add the file to the request with the key 'file'
      var file = await http.MultipartFile.fromPath('file', imageFile.path);
      request.files.add(file);

      // Send the request
      var response = await request.send();

      // Read and decode the response body
      var responseString = await response.stream.bytesToString();
      Map<String, dynamic> responseBody = jsonDecode(responseString);
      final body = responseBody["data"];

      if (body == null) {
        throw ApiFailure("no response from server");
      }
      if(body is String){
        throw ApiFailure(body.toString());
      }
      debugPrint(body);
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
      return ResultModel(
        color: body["color"],
        id: body["id"].toString(),
        name: body[ "Vehicle_brand"],
        numberPlate: body["plate_number"].toString(),
        ownerFullName: body["owner_fullname"],
        registeredAt: body["registered_at"],
        driversImage: body["drivers_image"],
        carsImage: body["cars_image"],
        ownerGender: body["owner_gender"],
        ownersNationality : body["owners_nationality" ] ,
        ownersAge: body["owners_age"],
        registrationExpiry: body["registration_expiry"],
        vehicleCategory: body["vehicle_category"],
        chasisNumber: body["chasis_number"],
        nationalIdentification:body["national_identification"],
        vehicleBrand: body["Vehicle_brand"],
        registered: body["Registered"],
        model: body["Vehicle_model"]
      );
    } on ApiFailure catch (e){
      throw {"error": e.message};
    }
    catch (e) {
      debugPrint(e.toString());
      throw {"error": ApiFailure(e.toString())};
    }
  }
}
