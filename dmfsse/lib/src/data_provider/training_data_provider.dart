import 'dart:convert';

import 'package:dmfsse/local_storage/user_preference.dart';

import '../../Ip/ip.dart';
import '../models/training.dart';
import 'package:http/http.dart' as http;

class TrainingDataProvider {
  String baseUrl = "${Ip.ip}/trainings";

  late String accessToken;
  void init() async {
    UserPreference userPreference = UserPreference();
    accessToken = (await userPreference.getUserToken());
    print("the toke is $accessToken");
  }

  Future<List<Training>> getTrainings() async {
    init();
    try {
      final response = await http.get(Uri.parse(baseUrl),
          headers: {'x-access-token': accessToken.toString()});
      if (response.statusCode == 200) {
        final trainingData = json.decode(response.body) as List;
        print('status code: ${response.body}');
        return trainingData.map((e) => Training.fromJson(e)).toList();
        // return Training.fromJson(jsonDecode(response.body));
      } else {
        print('status code: ${response.body}');
        throw Exception("No internet. Failed to load course");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
