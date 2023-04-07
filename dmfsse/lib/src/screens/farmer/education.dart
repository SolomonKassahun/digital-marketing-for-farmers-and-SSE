import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/training/training_bloc.dart';
import '../../bloc/training/training_event.dart';
import '../../bloc/training/training_state.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TrainingBloc>(context).add(GetTrainingEvent());
    return BlocBuilder<TrainingBloc, TrainingState>(
      builder: (context, state) {
        if (state is GetTrainingInitial) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        } else if (state is GetTrainingSucess) {
          return Center(
            child: Text(state.trainings.first.title),
          );
        } else {
          return const Center(
            child: Text("No Internet"),
          );
        }
        return const SizedBox();
      },
    );
  }
}
