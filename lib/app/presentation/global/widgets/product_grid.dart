import 'package:flutter/material.dart';
import '../../../data/services/local/product_service.dart';
import '../../../data/services/local/cart_service.dart';
import '../../global/colors.dart';
import '../../global/widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();
    final cartService = CartService();

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
            itemCount: productService.featuredProducts.length,
            itemBuilder: (context, index) {
              final product = productService.featuredProducts[index];
              return ProductCard(
                product: product,
                onTap: () {
                  print('Tap en ${product.title}');
                },
                onAddToCart: () {
                  cartService.addProduct(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.title} agregado al carrito'),
                      backgroundColor: AppColors.success,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
