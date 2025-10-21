import 'package:flutter/material.dart';
import '../../../domain/models/product.dart';
import '../../global/colors.dart';
import '../../global/widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  // Datos mock usando el modelo
  static final List<Product> _mockProducts = [
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
    // Más productos...
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Productos en oferta',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 350,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _mockProducts.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: _mockProducts[index],
                onTap: () {
                  // TODO: Navegar a detalle del producto
                  print('Tap en ${_mockProducts[index].title}');
                },
                onAddToCart: () {
                  // TODO: Agregar al carrito
                  print('Agregar ${_mockProducts[index].title} al carrito');
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
