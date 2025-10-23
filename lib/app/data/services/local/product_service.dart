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
      imageUrl:
          'https://imgs.search.brave.com/V2us6v5jZ4MZgRt7TATR-p3HGhFhepvqJgZPJBAjRjo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/cGl4YWJheS5jb20v/cGhvdG8vMjAxOS8w/MS8yOC8yMi8wMi9h/cHBsZXMtMzk2MTM1/N182NDAuanBn',
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
      imageUrl:
          'https://imgs.search.brave.com/islqyWXMvBjVOwYJ0zXj3Zfn7acQwk9ENDqV78htL5s/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zYXAu/Y29tLmJvL2Nkbi9z/aG9wL2ZpbGVzL0h1/ZXZvRG9ibGUuanBn/P3Y9MTc0NDcyNzEz/MCZ3aWR0aD0xNDQ1',
      rating: 4.5,
      reviewCount: 18,
    ),
    Product(
      id: '3',
      title: 'Leche Pil 1L',
      category: 'Lácteos y Huevos',
      price: 8.50,
      discountPercentage: 0,
      imageUrl:
          'https://imgs.search.brave.com/TBwxbHzCN3k14PS0DPlfI9yhSZlaMOW2_hYGkyuffDo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9mYXJt/YWNvcnAuY29tL2Nk/bi9zaG9wL2ZpbGVz/Lzc3NzI5MDUwMDAz/Nl83MDB4NzAwLmpw/Zz92PTE3MTQ0MzY1/MTI',
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
      imageUrl:
          'https://imgs.search.brave.com/34_YHdAWw7sqs8egazUnuZc5LXjw4TarUVBXmLgi0NM/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NDFyR3VwNGRMUkwu/anBn',
      rating: 4.7,
      reviewCount: 32,
    ),
    Product(
      id: '5',
      title: 'Queso fresco 500g',
      category: 'Lácteos y Huevos',
      price: 35.00,
      discountPercentage: 0,
      imageUrl:
          'https://imgs.search.brave.com/yqPqulEPz_t0lbJQGW-umt5bNBQC1q8kqnvK3htqxYY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4w/LnVuY29tby5jb20v/ZXMvcG9zdHMvMy8y/LzMvcXVlc29fZnJl/c2NvXzU0MzIzXzJf/NjAwLmpwZw',
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
