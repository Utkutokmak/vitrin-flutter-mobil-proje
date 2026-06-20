import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/product.dart';

/// Ürün verisini yerel JSON dosyasından okuyan repository.
///
/// Yönergenin "Gün 4: Listeleme ve JSON Yapısı (Simülasyon)" hedefiyle
/// uyumlu olarak veri ağ üzerinden çekilmez; assets/data/products.json
/// içinden simüle edilir. Ekstra paket gerekmez (rootBundle + dart:convert
/// Flutter/Dart SDK çekirdeğinin bir parçasıdır).
class ProductRepository {
  static const String _assetPath = 'assets/data/products.json';

  Future<List<Product>> loadProducts() async {
    final raw = await rootBundle.loadString(_assetPath);
    final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<String>> loadCategories() async {
    final products = await loadProducts();
    final categories = products.map((p) => p.category).toSet().toList();
    categories.sort();
    return categories;
  }
}
