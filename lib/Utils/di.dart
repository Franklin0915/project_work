import 'package:get_it/get_it.dart';
import 'package:vehicle_recognition/Utils/network_v2.dart';
import 'package:vehicle_recognition/api/plate_recognition_datasource.dart';
import 'package:vehicle_recognition/api/plate_recognition_repository.dart';

import '../api/plate_recognition_usecase.dart';
import 'network.dart';

class Injector {
  static late GetIt getIt;

  static void _initializeGetIt() {
    getIt = GetIt.instance;
  }

  static void registerDependencies() {
    _initializeGetIt();
    getIt.registerLazySingleton<NetworkService>(() => NetworkService());
    getIt.registerLazySingleton<NetworkServiceV2>(() => NetworkServiceV2());
    getIt.registerLazySingleton<RecognizePlateRemoteDatasource>(
        () => RecognizePlateRemoteDatasourceImpl(getIt.get<NetworkService>()));
    getIt.registerLazySingleton<RecognizePlateRepository>(
      () => RecognizePlateRepositoryImpl(getIt.get<RecognizePlateRemoteDatasource>()),
    );
    getIt.registerLazySingleton<RecognizePlate>(
      () => RecognizePlate(getIt.get<RecognizePlateRepository>()),
    );
  }
}
