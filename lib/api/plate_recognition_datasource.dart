import 'package:image_picker/image_picker.dart';

abstract class RecognizePlateRemoteDatasource {
  Future<String> recognizePlate(XFile imageFile);
}

class RecognizePlateRemoteDatasourceImpl implements RecognizePlateRemoteDatasource {
  @override
  Future<String> recognizePlate(XFile imageFile) {
    // TODO: implement recognizePlate
    throw UnimplementedError();
  }
}
