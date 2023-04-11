class MessageInfo {
  String id;
  // String message;
  String? createdAt;
  String? updatedAt;
  String firstName;
  String lastName;
  String? profilePicture;

  MessageInfo({
    required this.id,
    required this.profilePicture,
    required this.firstName,
    required this.lastName,
    // required this.message,
    this.createdAt,
    this.updatedAt,
    // required this.firstName,
    // required this.lastName,
    // required this.profilePicture
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        // 'sender': sender,
        // 'reciever': reciever,
        // 'message': message,
        'firstName': firstName,
        'lastName': lastName,
        'profilePicture': profilePicture,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };
  MessageInfo.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        // sender = json['sender'],
        // reciever = json['reciever'],
        // message = json['message'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        profilePicture = json['profilePicture'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];

  // Map
}

class MessageBody {
  String message;
  MessageBody({required this.message});
  Map<String, dynamic> toJson() => {'message': message};
  MessageBody.fromJson(Map<String, dynamic> json) : message = json['message'];
}
