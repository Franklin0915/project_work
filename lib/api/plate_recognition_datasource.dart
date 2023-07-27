import 'package:image_picker/image_picker.dart';
import 'package:vehicle_recognition/Utils/constants.dart';
import 'package:vehicle_recognition/Utils/network.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

abstract class RecognizePlateRemoteDatasource {
  Future<String> recognizePlate(XFile imageFile);
}

class RecognizePlateRemoteDatasourceImpl implements RecognizePlateRemoteDatasource {
  @override
  Future<String> recognizePlate(XFile imageFile) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var request = http.MultipartRequest(
      'POST', Uri.parse(kBaseUrl)
    );
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));
    var streadmedResponse = await request.send();
    var response = http.Response.fromStream(streadmedResponse);
    print('RESPONSE : $response');
    return "From API";
  }
}
