import 'package:flutter/foundation.dart';
import '../../../domain/models/product.dart';

class ProductService extends ChangeNotifier {
  static final ProductService _instance = ProductService._internal();
  factory ProductService() => _instance;
  ProductService._internal();

  // Productos principales de tu e-market
  static final List<Product> _products = [
    Product(
      id: '1',
      title: '10 Manzanas de Vallegrande',
      category: 'Frutas y Verduras',
      price: 12.00,
      originalPrice: 17.00,
      discountPercentage: 30,
      imageUrl: 'assets/images/manzanas.png',
      rating: 4.0,
      reviewCount: 24,
    ),
    Product(
      id: '2',
      title: 'Huevo marrón 60 unidades',
      category: 'Lácteos y Huevos',
      price: 45.00,
      originalPrice: 60.00,
      discountPercentage: 25,
      imageUrl: 'assets/images/huevos.png',
      rating: 4.5,
      reviewCount: 18,
    ),
    Product(
      id: '3',
      title: 'Leche Pil 1L',
      category: 'Lácteos y Huevos',
      price: 8.50,
      discountPercentage: 0,
      imageUrl: 'assets/images/leche.png',
      rating: 4.3,
      reviewCount: 45,
    ),
    Product(
      id: '4',
      title: 'Pan integral artesanal',
      category: 'Panadería',
      price: 15.00,
      originalPrice: 18.00,
      discountPercentage: 17,
      imageUrl: 'assets/images/pan.png',
      rating: 4.7,
      reviewCount: 32,
    ),
    Product(
      id: '5',
      title: 'Queso fresco 500g',
      category: 'Lácteos y Huevos',
      price: 35.00,
      discountPercentage: 0,
      imageUrl: 'assets/images/queso.png',
      rating: 4.2,
      reviewCount: 28,
    ),
  ];

  List<Product> get products => List.unmodifiable(_products);

  List<Product> get featuredProducts =>
      _products.where((p) => p.discountPercentage > 0).toList();

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Product> getProductsByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }
}
