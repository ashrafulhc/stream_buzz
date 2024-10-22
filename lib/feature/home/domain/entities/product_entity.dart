class ProductEntity {
  int? id;
  String? title;
  double? price;
  String? category;
  String? description;
  String? image;

  ProductEntity({
    this.id,
    this.title,
    this.price,
    this.category,
    this.description,
    this.image,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
    id: json["id"],
    title: json["title"],
    price: (json["price"] is int)
        ? (json["price"] as int).toDouble()
        : (json["price"] as double),
    category: json["category"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "category": category,
    "description": description,
    "image": image,
  };
}
