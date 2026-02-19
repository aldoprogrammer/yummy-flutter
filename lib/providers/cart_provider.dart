import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/food_item.dart';

/// Provider untuk mengelola state cart menggunakan ChangeNotifier
class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  // Getter untuk items di cart
  List<CartItem> get items => List.unmodifiable(_items);

  // Getter untuk total items di cart
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  // Getter untuk total harga
  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  // Method untuk menambahkan item ke cart
  void addToCart(FoodItem foodItem) {
    // Cek apakah item sudah ada di cart
    final existingIndex = _items.indexWhere(
      (item) => item.foodItem.id == foodItem.id,
    );

    if (existingIndex >= 0) {
      // Jika sudah ada, increment quantity
      _items[existingIndex].increment();
    } else {
      // Jika belum ada, tambahkan item baru
      _items.add(CartItem(foodItem: foodItem));
    }

    notifyListeners();
  }

  // Method untuk menghapus item dari cart
  void removeFromCart(String foodItemId) {
    _items.removeWhere((item) => item.foodItem.id == foodItemId);
    notifyListeners();
  }

  // Method untuk update quantity item di cart
  void updateQuantity(String foodItemId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(foodItemId);
      return;
    }

    final existingIndex = _items.indexWhere(
      (item) => item.foodItem.id == foodItemId,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity = quantity;
      notifyListeners();
    }
  }

  // Method untuk increment quantity item
  void incrementItem(String foodItemId) {
    final existingIndex = _items.indexWhere(
      (item) => item.foodItem.id == foodItemId,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].increment();
      notifyListeners();
    }
  }

  // Method untuk decrement quantity item
  void decrementItem(String foodItemId) {
    final existingIndex = _items.indexWhere(
      (item) => item.foodItem.id == foodItemId,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].decrement();
      if (_items[existingIndex].quantity == 0) {
        _items.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  // Method untuk cek apakah item ada di cart
  bool isInCart(String foodItemId) {
    return _items.any((item) => item.foodItem.id == foodItemId);
  }

  // Method untuk get quantity item di cart
  int getItemQuantity(String foodItemId) {
    final item = _items.firstWhere(
      (item) => item.foodItem.id == foodItemId,
      orElse: () => CartItem(foodItem: FoodItem(
        id: '',
        name: '',
        price: 0,
        rating: 0,
        reviewCount: 0,
        imageUrl: '',
        description: '',
        deliveryTime: 0,
        category: '',
      )),
    );
    return item.quantity;
  }

  // Method untuk clear cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

