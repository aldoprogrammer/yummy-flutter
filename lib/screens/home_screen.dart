import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/food_provider.dart';
import '../widgets/food_card.dart';
import '../widgets/category_button.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/cart_footer.dart';
import 'category_detail_screen.dart';

/// Home screen dengan search, categories, dan food items
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // Header dengan location dan notification
            _buildHeader(),
            // Search bar dan filter
            _buildSearchSection(),
            // Categories
            _buildCategoriesSection(),
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Buyers' Choice section
                    _buildTopBuyersChoiceSection(),
                    // Explore Healthy section
                    _buildExploreHealthySection(),
                    const SizedBox(height: 100), // Space untuk cart footer
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
      ),
      bottomSheet: CartFooter(
        onTap: () {
          // Navigate to orders screen (bisa ditambahkan nanti)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Orders screen coming soon!')),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Color(0xFF4CAF50),
                size: 20,
              ),
              const SizedBox(width: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Order now',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const Text(
                    '123 Jakarta',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_drop_down, size: 20),
            ],
          ),
          Stack(
            children: [
              const Icon(
                Icons.notifications_outlined,
                size: 24,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey.shade600, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Search Avocado, Almonds, Broccoli...',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.tune,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Consumer<FoodProvider>(
      builder: (context, foodProvider, child) {
        return Container(
          height: 100,
          margin: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: foodProvider.categories.map((category) {
                final isSelected = foodProvider.selectedCategory == category.id.toLowerCase();
              return CategoryButton(
                category: category,
                isSelected: isSelected,
                onTap: () {
                  // Navigate to category detail screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryDetailScreen(
                        categoryId: category.id,
                        categoryName: category.name,
                      ),
                    ),
                  );
                },
              );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBuyersChoiceSection() {
    return Consumer<FoodProvider>(
      builder: (context, foodProvider, child) {
        final topItems = foodProvider.topBuyersChoice;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Top Buyers' Choice",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4CAF50),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 230,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: topItems.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return Container(
                        width: 170,
                        margin: EdgeInsets.only(
                          left: index == 0 ? 0 : 12,
                        ),
                        child: FoodCard(foodItem: item),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExploreHealthySection() {
    return Consumer<FoodProvider>(
      builder: (context, foodProvider, child) {
        final healthyItems = foodProvider.foodItems
            .where((item) => item.category == 'Vegetables')
            .take(4)
            .toList();
        
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Explore Healthy',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4CAF50),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 230,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: healthyItems.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                    return GestureDetector(
                      onTap: () {
                        // Navigate to category detail
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CategoryDetailScreen(
                              categoryId: 'vegetables',
                              categoryName: 'Vegetables',
                            ),
                          ),
                        );
                      },
                        child: Container(
                          width: 170,
                          margin: EdgeInsets.only(
                            left: index == 0 ? 0 : 12,
                          ),
                          child: FoodCard(foodItem: item),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

