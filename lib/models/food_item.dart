/// Model untuk data makanan/item yang dijual
class FoodItem {
  final String id;
  final String name;
  final double price;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final String description;
  final int deliveryTime; // dalam menit
  final String category;
  final bool isFavorite;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.description,
    required this.deliveryTime,
    required this.category,
    this.isFavorite = false,
  });

  // Method untuk copy dengan perubahan tertentu
  FoodItem copyWith({
    String? id,
    String? name,
    double? price,
    double? rating,
    int? reviewCount,
    String? imageUrl,
    String? description,
    int? deliveryTime,
    String? category,
    bool? isFavorite,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

