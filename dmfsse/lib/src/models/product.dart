class Product {
  String? id;
  String name;
  int price;
  String description;
  String? photo;
  int amount;
  bool? soldout;
  PostedBy? postedBy;
  String? createdAt;
  String? updatedAt;
  Product(
      {this.id,
      required this.name,
      this.photo,
      required this.price,
      required this.description,
      required this.amount,
      this.soldout,
      this.createdAt,
      this.updatedAt,
      this.postedBy});
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'description': description,
        'photo': photo,
        'amount': amount,
        'soldout': soldout,
        'postedBy': postedBy,
        'createdAt':createdAt,
        'updatedAt':updatedAt
        
      };
  Product.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        price = json['price'],
        description = json['description'],
        photo = json['photo'],
        amount = json['amount'],
        soldout = json['soldout'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        postedBy = PostedBy.fromJson(json['postedBy']);
}

class PostedBy {
  String id;
  String firstName;
  String lastName;
  String roles;
  String? profilePicture;
  PostedBy(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.roles,
       this.profilePicture});
  Map<String, dynamic> toJson() => {
        'id': id,
        'fistName': firstName,
        'lastName': lastName,
        'roles': roles,
        'profilePicture': profilePicture
      };
  PostedBy.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        roles = json['roles'],
        profilePicture = json['profilePicture'];
}
