/// Bir ürünün veri modeli.
///
/// `fromJson` ile yerel JSON simülasyon verisinden (assets/data/products.json)
/// nesneye dönüştürülür, `toJson` ise tersini yapar.
class Product {
  final String id;
  final String name;
  final String brand;
  final String category;
  final double price;
  final String description;
  final double rating;
  final String imageAsset;
  final Map<String, String> specs;

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.price,
    required this.description,
    required this.rating,
    required this.imageAsset,
    required this.specs,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      rating: (json['rating'] as num).toDouble(),
      imageAsset: json['imageAsset'] as String,
      specs: Map<String, String>.from(json['specs'] as Map),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'category': category,
      'price': price,
      'description': description,
      'rating': rating,
      'imageAsset': imageAsset,
      'specs': specs,
    };
  }
}
