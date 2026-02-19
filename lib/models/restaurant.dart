import 'food_item.dart';

/// Model untuk data restaurant
class Restaurant {
  final String id;
  final String name;
  final double rating;
  final int reviewCount;
  final int deliveryTime; // dalam menit
  final String priceRange; // $, $$, $$$, etc
  final String description;
  final String heroImageUrl;
  final List<String> tags;
  final List<FoodItem> menuItems;

  Restaurant({
    required this.id,
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.deliveryTime,
    required this.priceRange,
    required this.description,
    required this.heroImageUrl,
    required this.tags,
    required this.menuItems,
  });
}

