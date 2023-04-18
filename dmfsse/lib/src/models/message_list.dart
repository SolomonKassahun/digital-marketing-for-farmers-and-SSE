class ListOfMessage {
  String id;
  String message;
  Sender? sender;
  Reciever? reciever;
  ListOfMessage(
      {required this.id, required this.message, this.sender, this.reciever});
  Map<String, dynamic> toJson() =>
      {'id': id, 'message': message, 'sender': sender, 'reciever': reciever};
  ListOfMessage.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        message = json['reciever'],
        sender = Sender.fromJson(json['sender']),
        reciever = Reciever.fromJson(json['reciever']);
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
      : id = json['id'],
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
