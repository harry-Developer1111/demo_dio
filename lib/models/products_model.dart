class ProductModel {
  final String id;
  final String name;
  final int year;
  final double price;

  ProductModel({
    required this.id,
    required this.name,
    required this.year,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      year: int.tryParse(
        json["data"]?["year"]?.toString() ?? "",
      ) ?? 0,
      price: double.tryParse(
        json["data"]?["price"]?.toString() ?? "",
      ) ?? 0.0,
    );
  }
}