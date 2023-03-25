class Product {
  int? ProductId;
  String? title;
  String? price;
  String? description;
  String? photos;
  Product({this.ProductId, this.title, this.photos, this.price, this.description});
  Map<String, dynamic> toJson()=>{
    'ProductId':ProductId,
    'title':title,
    'price':price,
    'description':description,
    'photos':photos
  };
  Product.from(Map<String, dynamic> json):
    ProductId= json['ProductId'],
    title = json['title'],
    price = json['price'],
    description = json['description'],
    photos = json['photos'];



  
}