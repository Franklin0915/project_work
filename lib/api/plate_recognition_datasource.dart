import 'package:image_picker/image_picker.dart';
import 'package:vehicle_recognition/Utils/constants.dart';
import 'package:vehicle_recognition/Utils/network.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class RecognizePlateRemoteDatasource {
  Future<String> recognizePlate(XFile imageFile);
}

class RecognizePlateRemoteDatasourceImpl implements RecognizePlateRemoteDatasource {
  @override
  Future<String> recognizePlate(XFile imageFile) async{
      // 
      final dio = Dio();

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFile.path),
    });

    final response = await dio.post(
      kBaseUrl,
      data: formData,
    );
    print('STATUS CODE : ${response.statusCode}');
    if (response.statusCode == 200) {
     // Decode JSON response
      final responseData = response.data as Map<String, dynamic>;
      print('DATA : $responseData');
      if (responseData.containsKey('data')) {
        String dataValue = responseData['data'] as String;
        print('Data Value: $dataValue');
        return dataValue;
      }
      return "Couldn't find plate number ";
    } else {
      return "Server returned error";
    }


    // 
  }
}
