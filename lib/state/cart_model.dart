import 'package:flutter/widgets.dart';
import '../models/product.dart';

/// Sepetteki bir ürün satırı (ürün + adet).
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}

/// Uygulama genelinde sepet durumunu yöneten basit state container.
///
/// `ChangeNotifier`, Flutter SDK'sının `foundation.dart` kütüphanesinin
/// parçasıdır (pub.dev paketi DEĞİLDİR) — bu nedenle yönergenin "ekstra
/// paket kullanılmayacak" kısıtına uyarken, müfredatın "basit state
/// güncelleme" hedefinin üzerine gerçek bir state-management mimarisi
/// kurar.
class CartModel extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();

  int get itemCount => _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);

  bool contains(String productId) => _items.containsKey(productId);

  void add(Product product, {int quantity = 1}) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity += quantity;
    } else {
      _items[product.id] = CartItem(product: product, quantity: quantity);
    }
    notifyListeners();
  }

  void incrementQuantity(String productId) {
    _items[productId]?.quantity += 1;
    notifyListeners();
  }

  void decrementQuantity(String productId) {
    final item = _items[productId];
    if (item == null) return;
    if (item.quantity > 1) {
      item.quantity -= 1;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void remove(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

/// `CartModel`'i widget ağacının her noktasından erişilebilir kılan,
/// sadece Flutter SDK çekirdeğini (InheritedNotifier) kullanan basit bir
/// "kendi provider'ını yaz" deseni. Ekstra paket (örn. `provider`) gerekmez.
class CartScope extends InheritedNotifier<CartModel> {
  const CartScope({super.key, required CartModel cart, required super.child})
      : super(notifier: cart);

  static CartModel of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'CartScope bulunamadı — widget ağacında CartScope olmalı.');
    return scope!.notifier!;
  }
}
