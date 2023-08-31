import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_recognition/Utils/errors.dart';
import 'package:vehicle_recognition/Utils/network.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_recognition/api/car_model.dart';
import '../Utils/constants.dart';
import '../Utils/network_v2.dart';
import 'dart:convert';

abstract class RecognizePlateRemoteDatasource {
  Future<CarModel> recognizePlate(XFile imageFile);
}

class RecognizePlateRemoteDatasourceImpl
    implements RecognizePlateRemoteDatasource {
  final NetworkService _networkService;

  RecognizePlateRemoteDatasourceImpl(this._networkService);

  @override
  Future<CarModel> recognizePlate(XFile imageFile) async {
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
      return CarModel(
        color: body["color"],
        id: body["id"].toString(),
        name: body["name"],
        numberPlate: body["plate_number"].toString(),
        ownerFullName: body["owner_fullname"],
        registeredAt: body["registered_at"],
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
