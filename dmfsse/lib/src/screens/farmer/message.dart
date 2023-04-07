import 'package:dmfsse/src/bloc/user/user_bloc.dart';
import 'package:dmfsse/src/bloc/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../local_storage/user_preference.dart';
import '../../bloc/user/user_event.dart';
import '../../models/login_info.dart';

class FarmerChat extends StatefulWidget {
  const FarmerChat({super.key});

  @override
  State<FarmerChat> createState() => _FarmerChatState();
}

class _FarmerChatState extends State<FarmerChat> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No Message"),
    );
  }
}
