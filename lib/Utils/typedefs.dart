import 'package:dartz/dartz.dart';
import 'errors.dart';
import 'network.dart';

abstract class Usecase<R, P> {
  Future<Either<UIError, R>> call(P param);
}

Future<T> guardedApiCall<T>(Function func) async {
  try {
    return await func() as T;
  } on ApiFailure catch (e) {
    throw NetworkFailure(e.message);
  }
}
