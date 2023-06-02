import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

import '../../bloc/training/training_bloc.dart';
import '../../bloc/training/training_event.dart';
import '../../bloc/training/training_state.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  void initState() {
    BlocProvider.of<TrainingBloc>(context).add(GetTrainingEvent());
    player.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
        print("is play is ${isPlaying}");
      });
    });
    // player.onDurationChanged.listen((newDuration) {
    //   setState(() {
    //     duration = newDuration;
    //   });
    // });
    // player.onPositionChanged.listen((newPosition) {
    //   position = newPosition;
    // });
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TrainingBloc>(context).add(GetTrainingEvent());
    return Scaffold(
      body: BlocBuilder<TrainingBloc, TrainingState>(
        builder: (context, state) {
          // if (state is GetTrainingInitial) {
          //   return const Center(
          //     child: CircularProgressIndicator(
          //       color: Colors.black,
          //     ),
          //   );
          // }
          if (state is GetTrainingSucess) {
            state.trainings.sort((a, b) => a.title.compareTo(b.title));
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: state.trainings.isEmpty
                    ? const Center(
                        child: Text("No Training"),
                      )
                    : Column(
                        children: state.trainings
                            .map((e) => Card(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          e.mediaFile
                                                  .toString()
                                                  .contains(".mp4")
                                              ? SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 200,
                                                  child: Chewie(
                                                    controller:
                                                        ChewieController(
                                                      videoPlayerController:
                                                          VideoPlayerController
                                                              .network(e
                                                                  .mediaFile
                                                                  .toString()),
                                                      autoPlay: true,
                                                      looping: true,
                                                    ),
                                                  ),
                                                )
                                              : e.mediaFile
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(".mp3")
                                                  ? Column(
                                                      children: [
                                                        Slider(
                                                          value: position
                                                              .inSeconds
                                                              .toDouble(),
                                                          onChanged:
                                                              (value) async {
                                                            final position =
                                                                Duration(
                                                                    seconds: value
                                                                        .toInt());
                                                            await player
                                                                .seek(position);
                                                            await player
                                                                .resume();
                                                          },
                                                          min: 0,
                                                          max: duration
                                                              .inSeconds
                                                              .toDouble(),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(position
                                                                .toString()),
                                                            Text((duration -
                                                                    position)
                                                                .toString()),
                                                          ],
                                                        ),
                                                        Center(
                                                          child: CircleAvatar(
                                                            radius: 25,
                                                            child: IconButton(
                                                              onPressed:
                                                                  () async {
                                                                if (isPlaying) {
                                                                  await player
                                                                      .pause();
                                                                } else {
                                                                  await player.play(
                                                                      UrlSource(
                                                                          e.mediaFile));
                                                                }
                                                              },
                                                              icon: Icon(isPlaying
                                                                  ? Icons.pause
                                                                  : Icons
                                                                      .play_arrow),
                                                              iconSize: 25,
                                                            ),
                                                          ),
                                                        )
                                                        // ElevatedButton(
                                                        //   child: Text("Audo"),
                                                        //   onPressed: () async {
                                                        //     await player.play(
                                                        //         UrlSource(e
                                                        //             .mediaFile));
                                                        //   },
                                                        // ),
                                                      ],
                                                    )
                                                  : CachedNetworkImage(
                                                      height: 200,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      imageUrl: e.mediaFile
                                                          .toString(),
                                                      fit: BoxFit.fill,
                                                      placeholder: (context,
                                                              url) =>
                                                          const Center(
                                                              child:
                                                                  SpinKitCircle(
                                                        color: Colors.black,
                                                      )),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                          //  const  SizedBox(height: 20,),
                                          Container(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e.title,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Text(
                                                    e.description,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                // Container(
                                //       margin: const EdgeInsets.all(10.0),
                                //       child: Card(
                                //         child: Column(
                                //           children: [
                                //         Container(
                                //           width: double.infinity,
                                //           height: 50,
                                //           margin: const EdgeInsets.all(15.0),
                                //           color: Colors.blue,
                                //           child: Center(
                                //             child: Text(
                                //               e.title,
                                //               style: const TextStyle(
                                //                   color: Colors.white, fontSize: 20),
                                //             ),
                                //           ),
                                //         ),
                                //         Container(
                                //           margin: const EdgeInsets.only(
                                //               top: 1.0, bottom: 15.0, left: 15.0),
                                //           child: Row(
                                //             children: [
                                //               CachedNetworkImage(
                                //                 height: 75.0,
                                //                 width: 75.0,
                                //                 imageUrl:e.mediaFile.toString(),
                                //                 fit: BoxFit.fill,
                                //                 placeholder: (context, url) =>
                                //                     const Center(
                                //                         child: SpinKitCircle(
                                //                   color: Colors.black,
                                //                 )),
                                //                 errorWidget: (context, url, error) =>
                                //                     const Icon(Icons.error),
                                //               ),
                                //               const SizedBox(
                                //                 width: 5,
                                //               ),
                                //               SizedBox(
                                //                 width:
                                //                     (MediaQuery.of(context).size.width -
                                //                         130),
                                //                 child: Text(
                                //                   e.description,
                                //                 ),
                                //               )
                                //             ],
                                //           ),
                                //         )
                                //       ],
                                //     ),
                                //   ),
                                // )
                                )
                            .toList(),
                      ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
