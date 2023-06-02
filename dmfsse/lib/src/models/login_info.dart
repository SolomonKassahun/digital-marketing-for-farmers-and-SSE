class LoginInfo {
  final String phoneNumber;
  final String password;

  LoginInfo(this.phoneNumber, this.password);

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'password': password,
      };
  LoginInfo.fromJson(Map<String, dynamic> json)
      : phoneNumber = json['phoneNumber'],
        password = json['password'];
}

class LoggedInUserInfo {
  //  "id": "642a9fd27ea7de1f0100c453",
  //   "firstName": "balcha",
  //   "lastName": "aba",
  //   "email": "balcha@gmail.com",
  //   "phoneNumber": "0940404040",
  //   "profilePicture": "http://google.com/may.png",
  //   "verified": true,
  //   "roles": [
  //       "sse"
  //   ],
  //   "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MmE5ZmQyN2VhN2RlMWYwMTAwYzQ1MyIsImlhdCI6MTY4MDY3NzkxNSwiZXhwIjoxNjgwNzY0MzE1fQ.pkJF3MY1G8sM2uEBDLfFf1GQnbkdasFSXv-opg6m9IY"
  final String id;
  final bool verified;

  final String accessToken;
  String firstName;
  String lastName;
  String? email;
  String phoneNumber;
  String? profilePicture;
  String? identifictionPicture;

  List<String> roles;
  LoggedInUserInfo(
      this.id,
      this.accessToken,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.profilePicture,
      this.identifictionPicture,
      this.roles,
      this.verified);
  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'verified': verified,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'profilePicture': profilePicture,
        'roles': roles,
        'identifictionPicture': identifictionPicture,
        'id': id
      };
  LoggedInUserInfo.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        verified = json['verified'],
        id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        phoneNumber = json['phoneNumber'],
        profilePicture = json['profilePicture'],
        identifictionPicture = json['identifictionPicture'],
        roles = json['roles'].map((role) => role).toList().cast<String>()
  // user = User.fromJson(json['user'])
  ;
}

class GetUserInfoByPhoneNumber {
 
  final String id;
  final bool? verified;

  final String? accessToken;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? profilePicture;
  String? identifictionPicture;

  List<String>? roles;
  GetUserInfoByPhoneNumber({
     required this.id,
      this.accessToken,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.profilePicture,
      this.identifictionPicture,
      this.roles,
      this.verified});
  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'verified': verified,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'profilePicture': profilePicture,
        'roles': roles,
        'identifictionPicture': identifictionPicture,
        'id': id
      };
  GetUserInfoByPhoneNumber.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        verified = json['verified'],
        id = json['_id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        phoneNumber = json['phoneNumber'],
        profilePicture = json['profilePicture'],
        identifictionPicture = json['identifictionPicture'],
        roles = json['roles'].map((role) => role).toList().cast<String>()
  // user = User.fromJson(json['user'])
  ;
}

