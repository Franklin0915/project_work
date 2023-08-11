import 'package:image_picker/image_picker.dart';
import 'package:vehicle_recognition/Utils/errors.dart';
import 'package:vehicle_recognition/Utils/network.dart';
import 'package:dio/dio.dart';

abstract class RecognizePlateRemoteDatasource {
  Future<String?> recognizePlate(XFile imageFile);
}

class RecognizePlateRemoteDatasourceImpl implements RecognizePlateRemoteDatasource {
  final NetworkService _networkService;

  RecognizePlateRemoteDatasourceImpl(this._networkService);

  @override
  Future<String?> recognizePlate(XFile imageFile) async {
    try {
      _networkService.isMultipartForm = true;
      final body = {'file': await MultipartFile.fromFile(imageFile.path, filename: imageFile.name)};
      final response = await _networkService.post(
        isFormData: true,
        url: "",
        body: body,
        headers: {'Content-Type': 'multipart/form-data'},
      );
      if (response.result != NetworkResult.SUCCESS) {
        throw ApiFailure(response.error?.message ?? "${response.status}");
      }
      return response.data!["data"];
    } catch (e) {
      throw ApiFailure(e.toString());
    }
  }
}
