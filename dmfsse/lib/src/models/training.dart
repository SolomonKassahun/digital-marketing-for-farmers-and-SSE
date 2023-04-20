import 'user.dart';

class Training {
  String? id;
  String title;
  String description;
  String mediaFile;
  PostedBy postedBy;
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
        postedBy = PostedBy.fromJson(json['postedBy']);
}

class PostedBy {
  String id;
  String firstName;
  String lastName;
  String roles;
  PostedBy(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.roles});
  Map<String, dynamic> toJson() =>
      {'id': id, 'fistName': firstName, 'lastName': lastName, 'roles': roles};
  PostedBy.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        roles = json['roles'];
}
