class User {
  String firstName;
  String lastName;
  String? email;
  String phoneNumber;
  List<String> roles;
  String profilePicture;
  String identifictionPicture;
  bool verified;
  String? createdAt;
  String? updatedAt;

  User({
    required this.firstName,
    required this.lastName,
    this.email,
    required this.phoneNumber,
    required this.roles,
    required this.profilePicture,
    required this.identifictionPicture,
    required this.verified,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> tojson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'roles': roles,
        'profilePicture': profilePicture,
        'identifictionPicture': identifictionPicture,
        'verified': verified,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };
  User.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        phoneNumber = json['phoneNumber'],
        roles = json['roles'].map((role) => role).toList().cast<String>(),
        profilePicture = json['profilePicture'],
        identifictionPicture = json['identifictionPicture'],
        verified = json['verified'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}

class ProfileUpdate {
  String id;
  String firstName;
  String lastName;
  String phoneNumber;
  ProfileUpdate({required this.id,required this.firstName,required this.lastName,required this.phoneNumber});
}