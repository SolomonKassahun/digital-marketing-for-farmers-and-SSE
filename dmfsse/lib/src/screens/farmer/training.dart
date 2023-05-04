import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  void initState() {
    BlocProvider.of<TrainingBloc>(context).add(GetTrainingEvent());
    super.initState();
  }

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
          return SingleChildScrollView(
            child: Column(
              children: state.trainings
                  .map((e) => Container(
                        margin: const EdgeInsets.all(10.0),
                        child: Card(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 50,
                                margin: const EdgeInsets.all(15.0),
                                color: Colors.blue,
                                child: Center(
                                  child: Text(
                                    e.title,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 1.0, bottom: 15.0, left: 15.0),
                                child: Row(
                                  children: [
                                    CachedNetworkImage(
                                      height: 75.0,
                                      width: 75.0,
                                      imageUrl:
                                          "https://caep.org/template/img/layout/program-buttons/field-crops-training-program.jpg",
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          const Center(
                                              child: SpinKitCircle(
                                        color: Colors.black,
                                      )),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                              130),
                                      child: Text(
                                        e.description,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
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
