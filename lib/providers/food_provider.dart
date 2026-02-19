import 'package:flutter/foundation.dart';
import '../models/food_item.dart';
import '../models/category.dart' as models;
import '../models/restaurant.dart';
import '../data/dummy_data.dart';

/// Provider untuk mengelola data makanan menggunakan ChangeNotifier
class FoodProvider with ChangeNotifier {
  List<FoodItem> _foodItems = [];
  List<models.Category> _categories = [];
  List<Restaurant> _restaurants = [];
  String _selectedCategory = 'all';

  FoodProvider() {
    _loadData();
  }

  // Getter untuk food items
  List<FoodItem> get foodItems => List.unmodifiable(_foodItems);

  // Getter untuk categories
  List<models.Category> get categories => List.unmodifiable(_categories);

  // Getter untuk restaurants
  List<Restaurant> get restaurants => List.unmodifiable(_restaurants);

  // Getter untuk selected category
  String get selectedCategory => _selectedCategory;

  // Getter untuk top buyers choice (rating tertinggi)
  List<FoodItem> get topBuyersChoice {
    final sorted = List<FoodItem>.from(_foodItems);
    sorted.sort((a, b) => b.rating.compareTo(a.rating));
    return sorted.take(4).toList();
  }

  // Getter untuk filtered food items berdasarkan category
  List<FoodItem> get filteredFoodItems {
    if (_selectedCategory == 'all') {
      return _foodItems;
    }
    return _foodItems
        .where((item) => item.category.toLowerCase() == _selectedCategory.toLowerCase())
        .toList();
  }

  // Method untuk load dummy data
  void _loadData() {
    _foodItems = DummyData.getFoodItems();
    _categories = DummyData.getCategories();
    _restaurants = DummyData.getRestaurants();
    notifyListeners();
  }

  // Method untuk set selected category
  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Method untuk toggle favorite
  void toggleFavorite(String foodItemId) {
    final index = _foodItems.indexWhere((item) => item.id == foodItemId);
    if (index >= 0) {
      _foodItems[index] = _foodItems[index].copyWith(
        isFavorite: !_foodItems[index].isFavorite,
      );
      notifyListeners();
    }
  }

  // Method untuk get restaurant by id
  Restaurant? getRestaurantById(String restaurantId) {
    try {
      return _restaurants.firstWhere((r) => r.id == restaurantId);
    } catch (e) {
      return null;
    }
  }
}

