class Order {
  String quantity;
  String offerPrice;
  String id;
  Order({required this.quantity, required this.offerPrice, required this.id});
  Map<String, dynamic> toJson() =>
      {'quantity': quantity, 'offerPrice': offerPrice};
  Order.fromJson(Map<String, dynamic> json)
      : quantity = json['quantity'],
        offerPrice = json['offerPrice'],
        id = json['id'];
}
