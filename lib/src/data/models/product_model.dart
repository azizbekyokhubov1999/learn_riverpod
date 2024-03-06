import 'dart:convert';

List<Products> productsFromJson(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  final String? id;
  final String name;
  final String description;
  final String price;

  Products({
     this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
  };
}
