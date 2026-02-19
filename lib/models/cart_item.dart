import 'food_item.dart';

/// Model untuk item di cart
class CartItem {
  final FoodItem foodItem;
  int quantity;

  CartItem({
    required this.foodItem,
    this.quantity = 1,
  });

  // Getter untuk total harga item (harga * quantity)
  double get totalPrice => foodItem.price * quantity;

  // Method untuk increment quantity
  void increment() {
    quantity++;
  }

  // Method untuk decrement quantity
  void decrement() {
    if (quantity > 1) {
      quantity--;
    }
  }
}

