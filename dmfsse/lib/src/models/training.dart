import 'user.dart';

class Training {
  String? id;
  String title;
  String description;
  String mediaFile;
  User postedBy;
  Training(id,
      {required this.description,
      required this.title,
      required this.mediaFile,
      required this.postedBy});
  Map<String, dynamic> toJson() => {
        "id": id,
        'description': description,
        'title': title,
        'mediaFile': mediaFile,
        'postedBy': postedBy
      };
  Training.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        description = json['description'],
        title = json['title'],
        mediaFile = json['mediaFile'],
        postedBy = User.fromJson(json['postedBy']);
}
