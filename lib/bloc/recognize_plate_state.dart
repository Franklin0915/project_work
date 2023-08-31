import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vehicle_recognition/api/car_model.dart';

part 'recognize_plate_state.freezed.dart';

@freezed
class RecognizePlateState with _$RecognizePlateState {
  const factory RecognizePlateState.initial() = _RecognizePlateStateInitial;

  const factory RecognizePlateState.loading() = _RecognizePlateStateLoading;

  const factory RecognizePlateState.success({required CarModel result}) = _RecognizePlateStateSuccess;

  const factory RecognizePlateState.error({required String message}) = _RecognizePlateStateError;
}
