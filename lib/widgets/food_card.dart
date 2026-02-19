import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../providers/cart_provider.dart';
import '../providers/food_provider.dart';
import '../screens/product_detail_screen.dart';
import 'adaptive_image.dart';

/// Widget untuk menampilkan card makanan
class FoodCard extends StatelessWidget {
  final FoodItem foodItem;
  final bool showAddButton;

  const FoodCard({
    super.key,
    required this.foodItem,
    this.showAddButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final isInCart = cartProvider.isInCart(foodItem.id);

    return GestureDetector(
      onTap: () {
        // Navigate to product detail screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(foodItem: foodItem),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
          // Image dengan favorite button
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: AdaptiveImage(
                  imageUrl: foodItem.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Favorite button
              Positioned(
                top: 6,
                right: 6,
                child: Consumer<FoodProvider>(
                  builder: (context, foodProvider, child) {
                    return GestureDetector(
                      onTap: () {
                        foodProvider.toggleFavorite(foodItem.id);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          foodItem.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: foodItem.isFavorite ? Colors.red : Colors.white,
                          size: 18,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  foodItem.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color(0xFF4CAF50),
                      size: 14,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${foodItem.rating}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF4CAF50),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${foodItem.deliveryTime} mins',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                if (showAddButton) ...[
                  const SizedBox(height: 6),
                  // Add/Remove button
                  if (isInCart)
                    Consumer<CartProvider>(
                      builder: (context, cart, child) {
                        final quantity = cart.getItemQuantity(foodItem.id);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${foodItem.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    cart.decrementItem(foodItem.id);
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF4CAF50),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '$quantity',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    cart.incrementItem(foodItem.id);
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF4CAF50),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${foodItem.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            cartProvider.addToCart(foodItem);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0xFF4CAF50),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }
}

