class Offer {
  String id;
  int quantity;
  int offerPrice;
  String accepted;
  String canRate;
  OrderBy orderBy;
  OfferedProduct offeredProduct;
  String? createdAt;
  String? updatedAt;
  Offer(
      {required this.id,
      required this.quantity,
      required this.offerPrice,
      required this.accepted,
      required this.canRate,
      required this.orderBy,
      required this.offeredProduct,
      this.createdAt,
      this.updatedAt});
  Map<String, dynamic> toJson() => {
        'id': id,
        'quantity': quantity,
        'offerPrice': offerPrice,
        'accepted': accepted,
        'canRate': canRate,
        'orderBy': orderBy,
        'offeredProduct': offeredProduct,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };
  Offer.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        quantity = json['quantity'],
        offerPrice = json['offerPrice'],
        accepted = json['accepted'],
        canRate = json['canRate'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        orderBy = OrderBy.fromJson(json['orderBy']),
        offeredProduct = OfferedProduct.fromJson(json['product']);
}

class OrderBy {
  String id;
  String firstName;
  String lastName;
  List<String> roles;
  OrderBy(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.roles});
  Map<String, dynamic> toJson() =>
      {'id': id, 'firstName': firstName, 'lastName': lastName, 'roles': roles};
  OrderBy.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        roles = json['roles'].map((role) => role).toList().cast<String>();
}

class OfferedProduct {
  String id;
  String name;
  int price;
  String description;
  String userId;
  OfferedProduct(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.userId});
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'description': description,
        'userId': userId
      };
  OfferedProduct.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        price = json['price'],
        description = json['description'],
        userId = json['postedBy'];
}

class OfferUpdateData {
  String offerId;
  String accepted;
  String canRate;
  int quantity;
  int offerPrice;
  OfferUpdateData(

      {
        required this.offerId,
        required this.accepted,
      required this.canRate,
      required this.quantity,
      required this.offerPrice});
}
