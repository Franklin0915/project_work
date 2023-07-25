import 'package:vehicle_recognition/bloc/recognize_plate_events.dart';
import 'package:vehicle_recognition/bloc/recognize_plate_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/plate_recognition_usecase.dart';

class RecognizePlateBloc extends Bloc<AppEvents, RecognizePlateState> {
  final RecognizePlate recognizePlate;

  RecognizePlateBloc(this.recognizePlate) : super(const RecognizePlateState.initial()) {
    on<RecognizePlateEvent>(_recognizePlate);
  }

  Future<void> _recognizePlate(RecognizePlateEvent event, Emitter<RecognizePlateState> emit) async {
    emit(const RecognizePlateState.loading());
    try {
      final result = await recognizePlate(RecognizePlateParam(event.imageFile));
      result.fold(
        (l) => emit(RecognizePlateState.error(message: l.message)),
        (r) => emit(RecognizePlateState.success(result: r)),
      );
    } catch (e) {
      emit(RecognizePlateState.error(message: e.toString()));
    }
  }
}
