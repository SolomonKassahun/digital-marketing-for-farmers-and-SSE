class User{
   int? UserId; 
   String? firstName;
   String? lastName;
   String? password;
   String? role;
   String? username;
  User({this.UserId, this.firstName, this.lastName, this.role, this.password, this.username});
  Map<String, dynamic> toJson() =>{
    'UserId':UserId,
    'firstName':firstName,
    'lastName':lastName,
    'password':password,
     'role':role,
     'username':username,
   
  };
  User.fromJson(Map<String, dynamic> json): 
   UserId=json['UserId'],
   firstName = json['firstName'],
   lastName=json['lastName'],
   password=json['password'],
    role = json['role'],
   username=json['username'];
  
}