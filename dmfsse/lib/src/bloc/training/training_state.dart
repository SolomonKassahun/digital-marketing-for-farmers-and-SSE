import '../../models/training.dart';

class TrainingState {}

class GetTrainingInitial extends TrainingState {}

class GetTrainingSucess extends TrainingState {
  List<Training> trainings;
  GetTrainingSucess({required this.trainings});
}

class GetTrainingFailure extends TrainingState {
  String message;
  GetTrainingFailure({required this.message});
}
