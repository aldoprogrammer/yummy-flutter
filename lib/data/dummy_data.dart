import '../models/food_item.dart';
import '../models/category.dart';
import '../models/restaurant.dart';

/// Class untuk menyimpan dummy data makanan, kategori, dan restaurant
class DummyData {
  // Dummy data untuk kategori
  static List<Category> getCategories() {
    return [
      Category(
        id: 'avocado',
        name: 'Avocado',
        imageUrl: 'assets/images/category_avocado.png',
      ),
      Category(
        id: 'almonds',
        name: 'Almonds',
        imageUrl: 'assets/images/category_almonds.png',
      ),
      Category(
        id: 'broccoli',
        name: 'Broccoli',
        imageUrl: 'assets/images/category_broccoli.png',
      ),
      Category(
        id: 'vegetables',
        name: 'Vegetables',
        imageUrl: 'assets/images/category_vegetables.png',
      ),
    ];
  }

  // Dummy data untuk food items
  static List<FoodItem> getFoodItems() {
    return [
      FoodItem(
        id: '1',
        name: 'Avocado Wrap',
        price: 12.50,
        rating: 4.8,
        reviewCount: 125,
        imageUrl: 'assets/images/avocado_wrap.png',
        description: 'Fresh avocado wrap with greens and protein',
        deliveryTime: 25,
        category: 'Avocado',
      ),
      FoodItem(
        id: '2',
        name: 'Organic Broccoli',
        price: 14.00,
        rating: 4.5,
        reviewCount: 89,
        imageUrl: 'assets/images/organic_broccoli.png',
        description: 'Fresh organic broccoli, locally sourced',
        deliveryTime: 30,
        category: 'Broccoli',
      ),
      FoodItem(
        id: '3',
        name: 'Roasted Almonds',
        price: 11.00,
        rating: 4.5,
        reviewCount: 156,
        imageUrl: 'assets/images/roasted_almonds.png',
        description: 'Premium roasted almonds, perfectly seasoned',
        deliveryTime: 32,
        category: 'Almonds',
      ),
      FoodItem(
        id: '4',
        name: 'Green Pea Bowl',
        price: 13.50,
        rating: 4.2,
        reviewCount: 67,
        imageUrl: 'assets/images/green_pea_bowl.png',
        description: 'Healthy green pea bowl with fresh vegetables',
        deliveryTime: 34,
        category: 'Vegetables',
      ),
      FoodItem(
        id: '5',
        name: 'Garden Salad',
        price: 10.00,
        rating: 4.6,
        reviewCount: 203,
        imageUrl: 'assets/images/garden_salad.png',
        description: 'Fresh garden salad with mixed vegetables',
        deliveryTime: 20,
        category: 'Vegetables',
      ),
      FoodItem(
        id: '6',
        name: 'Avocado Toast',
        price: 9.50,
        rating: 4.7,
        reviewCount: 312,
        imageUrl: 'https://images.unsplash.com/photo-1541519227354-08fa5d50c44d?w=400',
        description: 'Classic avocado toast with poached eggs',
        deliveryTime: 18,
        category: 'Avocado',
      ),
      FoodItem(
        id: '7',
        name: 'Almond Smoothie',
        price: 8.50,
        rating: 4.4,
        reviewCount: 145,
        imageUrl: 'https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=400',
        description: 'Creamy almond smoothie with fresh fruits',
        deliveryTime: 15,
        category: 'Almonds',
      ),
      FoodItem(
        id: '8',
        name: 'Broccoli Stir Fry',
        price: 15.00,
        rating: 4.9,
        reviewCount: 98,
        imageUrl: 'assets/images/organic_broccoli.png',
        description: 'Stir-fried broccoli with garlic and soy sauce',
        deliveryTime: 28,
        category: 'Broccoli',
      ),
      FoodItem(
        id: '9',
        name: 'Mixed Vegetables',
        price: 12.00,
        rating: 4.3,
        reviewCount: 178,
        imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400',
        description: 'Assorted fresh vegetables, steamed to perfection',
        deliveryTime: 22,
        category: 'Vegetables',
      ),
      FoodItem(
        id: '10',
        name: 'Avocado Salad Bowl',
        price: 13.00,
        rating: 4.6,
        reviewCount: 234,
        imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400',
        description: 'Fresh avocado salad with quinoa and vegetables',
        deliveryTime: 25,
        category: 'Avocado',
      ),
    ];
  }

  // Dummy data untuk restaurants
  static List<Restaurant> getRestaurants() {
    final foodItems = getFoodItems();
    
    return [
      Restaurant(
        id: 'rest1',
        name: 'Vegetables',
        rating: 4.8,
        reviewCount: 1200,
        deliveryTime: 25,
        priceRange: '\$\$',
        description: 'Authentic sushi experience',
        heroImageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800',
        tags: ['Healthy', 'Vegetables', 'Green', 'Garden'],
        menuItems: foodItems.where((item) => 
          item.category == 'Vegetables' || 
          item.category == 'Broccoli'
        ).toList(),
      ),
    ];
  }
}

