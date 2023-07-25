import 'package:get_it/get_it.dart';
import 'package:vehicle_recognition/api/plate_recognition_datasource.dart';
import 'package:vehicle_recognition/api/plate_recognition_repository.dart';

import '../api/plate_recognition_usecase.dart';

class Injector {
  static late GetIt getIt;

  static void _initializeGetIt() {
    getIt = GetIt.instance;
  }

  static void registerDependencies() {
    _initializeGetIt();
    getIt.registerLazySingleton<RecognizePlateRemoteDatasource>(() => RecognizePlateRemoteDatasourceImpl());
    getIt.registerLazySingleton<RecognizePlateRepository>(
      () => RecognizePlateRepositoryImpl(getIt.get<RecognizePlateRemoteDatasource>()),
    );
    getIt.registerLazySingleton<RecognizePlate>(
      () => RecognizePlate(getIt.get<RecognizePlateRepository>()),
    );
  }
}
