import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/food_provider.dart';
import '../models/restaurant.dart';
import '../widgets/food_card.dart';
import '../widgets/cart_footer.dart';
import '../widgets/adaptive_image.dart';

/// Screen untuk detail restaurant dengan menu items
class RestaurantDetailScreen extends StatelessWidget {
  final String restaurantId;

  const RestaurantDetailScreen({
    super.key,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Consumer<FoodProvider>(
        builder: (context, foodProvider, child) {
          final restaurant = foodProvider.getRestaurantById(restaurantId);
          
          if (restaurant == null) {
            return const Scaffold(
              body: Center(child: Text('Restaurant not found')),
            );
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Hero image section dengan curved background
                          _buildHeroSection(context, restaurant),
                          const SizedBox(height: 125), // Space untuk hero image
                          // Category filters
                          _buildCategoryFilters(),
                          // Menu items grid
                          _buildMenuItemsGrid(restaurant),
                          const SizedBox(height: 40), // Space untuk cart footer
                        ],
                      ),
                      // Restaurant info card (overlap dengan hero)
                      Positioned(
                        top: 220,
                        left: 0,
                        right: 0,
                        child: _buildRestaurantInfoCard(restaurant),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomSheet: CartFooter(
        onTap: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Orders screen coming soon!')),
          );
        },
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, restaurant) {
    return Stack(
      children: [
        // Hero image dengan background light green
        Container(
          width: double.infinity,
          height: 280,
          decoration: const BoxDecoration(
            color: Color(0xFFE8F5E9), // Light green background
          ),
          child: ClipRect(
            child: AdaptiveImage(
              imageUrl: restaurant.heroImageUrl,
              width: double.infinity,
              height: 280,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Back button
        Positioned(
          top: 50,
          left: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantInfoCard(Restaurant restaurant) {
    // Format review count
    String reviewText;
    if (restaurant.reviewCount >= 1000) {
      reviewText = '${(restaurant.reviewCount / 1000).toStringAsFixed(1)}K';
    } else {
      reviewText = restaurant.reviewCount.toString();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFF4CAF50),
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${restaurant.rating} ($reviewText reviews)',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.access_time,
                          color: Color(0xFF4CAF50),
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${restaurant.deliveryTime} mins',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      restaurant.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              // Price range
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  restaurant.priceRange,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: restaurant.tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return Consumer<FoodProvider>(
      builder: (context, foodProvider, child) {
        final categories = foodProvider.categories;
        return Container(
          height: 45,
          margin: const EdgeInsets.only(top: 16, bottom: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: categories.map((category) {
                final isSelected = foodProvider.selectedCategory == category.id.toLowerCase();
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF4CAF50).withOpacity(0.1) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF4CAF50) : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      category.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected ? const Color(0xFF4CAF50) : Colors.grey.shade700,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuItemsGrid(Restaurant restaurant) {
    return Consumer<FoodProvider>(
      builder: (context, foodProvider, child) {
        final menuItems = restaurant.menuItems;
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              return FoodCard(foodItem: menuItems[index]);
            },
          ),
        );
      },
    );
  }
}

