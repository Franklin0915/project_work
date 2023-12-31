import 'package:image_picker/image_picker.dart';
import 'package:vehicle_recognition/Utils/typedefs.dart';

import 'result_model.dart';
import 'plate_recognition_datasource.dart';

abstract class RecognizePlateRepository {
  Future<ResultModel> recognizePlate(XFile imageFile);
}

class RecognizePlateRepositoryImpl implements RecognizePlateRepository {
  final RecognizePlateRemoteDatasource _recognizePlateRemoteDatasource;

  RecognizePlateRepositoryImpl(this._recognizePlateRemoteDatasource);

  @override
  Future<ResultModel> recognizePlate(XFile imageFile) async {
    return await guardedApiCall(() => _recognizePlateRemoteDatasource.recognizePlate(imageFile));
  }
}
