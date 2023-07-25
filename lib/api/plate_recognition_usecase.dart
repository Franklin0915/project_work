import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_recognition/Utils/errors.dart';
import 'package:vehicle_recognition/Utils/typedefs.dart';
import 'package:vehicle_recognition/api/plate_recognition_repository.dart';

import 'plate_recognition_repository.dart';

class RecognizePlate implements Usecase<String, RecognizePlateParam> {
  final RecognizePlateRepository _recognizePlateRepository;

  RecognizePlate(this._recognizePlateRepository);

  @override
  Future<Either<UIError, String>> call(RecognizePlateParam param) async {
    try {
      final result = await _recognizePlateRepository.recognizePlate(param.imageFile);
      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(UIError(e.message));
    }
  }
}

class RecognizePlateParam {
  final XFile imageFile;
  RecognizePlateParam(this.imageFile);
}
