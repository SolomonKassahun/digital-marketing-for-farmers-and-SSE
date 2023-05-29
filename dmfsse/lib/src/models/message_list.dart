class ListOfMessage {
  String? id;
  String message;
  Sender sender;
  Reciever reciever;
  String? createdAt;
  String? updatedAt;
  ListOfMessage(
      { this.id, required this.message,required this.sender,required this.reciever, this.createdAt, this.updatedAt});
  Map<String, dynamic> toJson() =>
      {'id': id, 'message': message, 'sender': sender, 'reciever': reciever,'createdAt':createdAt,'updatedAt':updatedAt};
  ListOfMessage.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        message = json['message'],
        sender = Sender.fromJson(json['sender']),
        reciever = Reciever.fromJson(json['reciever']),
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}

class Sender {
  String? id;
  String? firstName;
  String? lastName;
  String? roles;
  Sender({this.id, this.firstName, this.lastName, this.roles});
  Map<String, dynamic> toJson() =>
      {'_id': id, 'firstName': firstName, 'lastName': lastName, 'roles': roles};
  Sender.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        roles = json['roles'];
}

class Reciever {
  String? id;
  String? firstName;
  String? lastName;
  String? roles;
  Reciever({this.id, this.firstName, this.lastName, this.roles});
  Map<String, dynamic> toJson() =>
      {'id': id, 'firstName': firstName, 'lastName': lastName, 'roles': roles};
  Reciever.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        roles = json['roles'];
}

class AllMessage {
  String id;
  String message;
  AllMessage({required this.id,required this.message});
}