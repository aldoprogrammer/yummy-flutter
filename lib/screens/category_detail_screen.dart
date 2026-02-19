import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/food_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/food_card.dart';
import '../widgets/cart_footer.dart';
import '../widgets/adaptive_image.dart';
import '../data/dummy_data.dart';

/// Screen untuk detail kategori (Category Details)
class CategoryDetailScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const CategoryDetailScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  // Hardcoded data untuk setiap kategori
  Map<String, dynamic> _getCategoryData() {
    switch (categoryId.toLowerCase()) {
      case 'avocado':
        return {
          'heroImageUrl': 'https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?w=800',
          'rating': 4.8,
          'reviewCount': 1200,
          'deliveryTime': 25,
          'priceRange': '\$\$',
          'description': 'Fresh and healthy avocado dishes',
          'tags': ['Healthy', 'Avocado', 'Fresh', 'Green'],
          'menuItems': DummyData.getFoodItems().where((item) => 
            item.category == 'Avocado'
          ).toList(),
        };
      case 'almonds':
        return {
          'heroImageUrl': 'https://images.unsplash.com/photo-1599599810769-bcde5a160d32?w=800',
          'rating': 4.6,
          'reviewCount': 850,
          'deliveryTime': 20,
          'priceRange': '\$\$',
          'description': 'Premium roasted and raw almonds',
          'tags': ['Healthy', 'Almonds', 'Nuts', 'Protein'],
          'menuItems': DummyData.getFoodItems().where((item) => 
            item.category == 'Almonds'
          ).toList(),
        };
      case 'broccoli':
        return {
          'heroImageUrl': 'https://images.unsplash.com/photo-1584270354949-c26b0d5b4a0c?w=800',
          'rating': 4.7,
          'reviewCount': 950,
          'deliveryTime': 28,
          'priceRange': '\$\$',
          'description': 'Organic and fresh broccoli dishes',
          'tags': ['Healthy', 'Broccoli', 'Organic', 'Green'],
          'menuItems': DummyData.getFoodItems().where((item) => 
            item.category == 'Broccoli'
          ).toList(),
        };
      case 'vegetables':
      default:
        return {
          'heroImageUrl': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800',
          'rating': 4.8,
          'reviewCount': 1200,
          'deliveryTime': 25,
          'priceRange': '\$\$',
          'description': 'Authentic sushi experience',
          'tags': ['Healthy', 'Vegetables', 'Green', 'Garden'],
          'menuItems': DummyData.getFoodItems().where((item) => 
            item.category == 'Vegetables'
          ).toList(),
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryData = _getCategoryData();
    
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hero image section
                      _buildHeroSection(context, categoryData),
                      const SizedBox(height: 75), // Space untuk hero image
                      // Menu items grid
                      _buildMenuItemsGrid(categoryData['menuItems'] as List),
                      const SizedBox(height: 40), // Space untuk cart footer
                    ],
                  ),
                  // Category info card (overlap dengan hero)
                  Positioned(
                    top: 220,
                    left: 0,
                    right: 0,
                    child: _buildCategoryInfoCard(categoryData),
                  ),
                ],
              ),
            ),
          ),
        ],
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

  Widget _buildHeroSection(BuildContext context, Map<String, dynamic> data) {
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
              imageUrl: data['heroImageUrl'] as String,
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

  Widget _buildCategoryInfoCard(Map<String, dynamic> data) {
    // Format review count
    String reviewText;
    final reviewCount = data['reviewCount'] as int;
    if (reviewCount >= 1000) {
      reviewText = '${(reviewCount / 1000).toStringAsFixed(1)}K';
    } else {
      reviewText = reviewCount.toString();
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
                      categoryName,
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
                          '${data['rating']} ($reviewText reviews)',
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
                          '${data['deliveryTime']} mins',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      data['description'] as String,
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
                  data['priceRange'] as String,
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
            children: (data['tags'] as List<String>).map((tag) {
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
                final isSelected = category.id.toLowerCase() == categoryId.toLowerCase();
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

  Widget _buildMenuItemsGrid(List menuItems) {
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
  }
}

