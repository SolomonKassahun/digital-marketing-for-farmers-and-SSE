import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_repository/training_data_repository.dart';
import '../../models/training.dart';
import 'training_event.dart';
import 'training_state.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  TrainingDataRepository trainingDataRepository;
  TrainingBloc({required this.trainingDataRepository})
      : super(GetTrainingInitial()) {
    on<TrainingEvent>((event, emit) async {
      if (event is GetTrainingEvent) {
        emit(GetTrainingInitial());
        try {
          List<Training> training = await trainingDataRepository.getTrainings();
          // ignore: unnecessary_type_check
          if (training != []) {
            emit(GetTrainingSucess(trainings: training));
          } else {
            emit(GetTrainingFailure(message: "No Internt"));
          }
        } catch (e) {
          emit(GetTrainingFailure(message: "No Internet"));
        }
      }
    });
  }
}
