import '../data_provider/training_data_provider.dart';
import '../models/training.dart';

class TrainingDataRepository {
  TrainingDataProvider trainingDataProiver;
  TrainingDataRepository({required this.trainingDataProiver});

  Future<List<Training>> getTrainings() {
    return trainingDataProiver.getTrainings();
  }
}
