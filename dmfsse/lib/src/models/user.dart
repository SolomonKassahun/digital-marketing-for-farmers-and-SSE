class User {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? profilePicture;
  String? identifictionPicture;
  String? password;
  String? role;

  User(
      {this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.profilePicture,
      this.identifictionPicture,
      this.role,
      this.password});
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'profilePicture': profilePicture,
        'password': password,
        'role': role,
        'identifictionPicture': identifictionPicture,
      };
  User.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        phoneNumber = json['phoneNumber'],
        profilePicture = json['profilePicture'],
        password = json['password'],
        role = json['role'],
        identifictionPicture = json['identifictionPicture'];
}
