class Product {
  final String id;
  final String title;
  final String category;
  final double price;
  final double? originalPrice;
  final int discountPercentage;
  final String imageUrl;
  final double rating;
  final int reviewCount;

  const Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.discountPercentage,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
  });

  // Getters útiles
  bool get hasDiscount => discountPercentage > 0;

  String get formattedPrice => 'Bs ${price.toStringAsFixed(2)}';

  String get formattedOriginalPrice =>
      originalPrice != null ? 'Bs ${originalPrice!.toStringAsFixed(2)}' : '';

  String get discountText => hasDiscount ? '-$discountPercentage%' : '';
}
