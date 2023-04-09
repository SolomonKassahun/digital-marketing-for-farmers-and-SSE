class Message {
  String _id;
  String sender;
  String reciever;
  String message;
  String? createdAt;
  String? updatedAt;
  // String firstName;
  // String lastName;
  // String profilePicture;

  Message(
    this._id, {
    required this.sender,
    required this.reciever,
    required this.message,
    this.createdAt,
    this.updatedAt,
    // required this.firstName,
    // required this.lastName,
    // required this.profilePicture
  });
  Map<String, dynamic> toJson() => {
        '_id': _id,
        'sender': sender,
        'reciever': reciever,
        'message': message,
        // 'firstName': firstName,
        // 'lastName': lastName,
        // 'profilePicture': profilePicture,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };
  Message.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        sender = json['sender'],
        reciever = json['reciever'],
        message = json['message'],
        // firstName = json['firstName'],
        // lastName = json['lastName'],
        // profilePicture = json['profilePicture'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];

  // Map
}
