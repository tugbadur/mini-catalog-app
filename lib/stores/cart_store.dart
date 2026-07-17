import 'package:flutter/foundation.dart';
import 'package:mini_catalog_app/models/product_model.dart';

class CartItem {
  const CartItem({required this.product, required this.quantity});

  final ProductModel product;
  final int quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(product: product, quantity: quantity ?? this.quantity);
  }
}

class CartStore extends ValueNotifier<List<CartItem>> {
  CartStore._() : super(const []);

  static final CartStore instance = CartStore._();

  void add(ProductModel product, int quantity) {
    final items = List<CartItem>.from(value);
    final index = items.indexWhere((item) => item.product.id == product.id);

    if (index == -1) {
      items.add(CartItem(product: product, quantity: quantity));
    } else {
      final item = items[index];
      items[index] = item.copyWith(quantity: item.quantity + quantity);
    }

    value = items;
  }

  void remove(ProductModel product) {
    value = value.where((item) => item.product.id != product.id).toList();
  }

  void clear() {
    value = const [];
  }
}
