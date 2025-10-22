import 'package:flutter/foundation.dart';
import '../../../domain/models/product.dart';
import '../../../domain/models/cart_item.dart';

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get shipping => subtotal > 50 ? 0.0 : 10.0; // Envío gratis > Bs 50

  double get total => subtotal + shipping;

  bool get isEmpty => _items.isEmpty;

  String get formattedSubtotal => 'Bs ${subtotal.toStringAsFixed(2)}';
  String get formattedShipping =>
      shipping == 0 ? 'Gratis' : 'Bs ${shipping.toStringAsFixed(2)}';
  String get formattedTotal => 'Bs ${total.toStringAsFixed(2)}';

  void addProduct(Product product) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      // Incrementar cantidad si ya existe
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + 1,
      );
    } else {
      // Agregar nuevo producto
      _items.add(CartItem(product: product, quantity: 1));
    }

    notifyListeners();
  }

  void removeProduct(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeProduct(productId);
      return;
    }

    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(quantity: quantity);
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
