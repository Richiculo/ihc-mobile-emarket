import 'package:flutter/material.dart';
import '../../global/colors.dart';
import '../../../data/services/local/cart_service.dart';
import '../../../domain/models/product.dart';

class RepeatOrderSection extends StatelessWidget {
  const RepeatOrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.refresh, size: 10, color: AppColors.primary),
              ),
              const SizedBox(width: 8),
              Text(
                'Repite tu pedido',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: 250,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Fila superior: Titulo + Imagen
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Yogurt Natural',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Comprado 4 veces',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                'Último 20/08/2025',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Imagen a la derecha
                        Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://imgs.search.brave.com/_yi32uNjh-F1WxK-k36ouH8iiav8Y22INqYGBrzJqc8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9mYXJt/YWNvcnAuY29tL2Nk/bi9zaG9wL2ZpbGVz/Lzc3NzI5MDUwMDI2/MzRfNzAweDcwMC5q/cGc_dj0xNzE0NDQx/MzE4',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(), // Empuja precio y botón hacia abajo
                    // Fila inferior: Precio + Botón
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bs 11,50',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Crear producto mock para agregar
                            final product = Product(
                              id: 'repeat_${index + 1}',
                              title: 'Yogurt Natural',
                              category: 'Lácteos y Huevos',
                              price: 11.50,
                              originalPrice: 15.00,
                              discountPercentage: 23,
                              imageUrl:
                                  'https://imgs.search.brave.com/_yi32uNjh-F1WxK-k36ouH8iiav8Y22INqYGBrzJqc8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9mYXJt/YWNvcnAuY29tL2Nk/bi9zaG9wL2ZpbGVz/Lzc3NzI5MDUwMDI2/MzRfNzAweDcwMC5q/cGc_dj0xNzE0NDQx/MzE4',
                              rating: 4.0,
                              reviewCount: 24,
                            );

                            CartService().addProduct(product);

                            // Mostrar feedback
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${product.title} agregado al carrito',
                                ),
                                backgroundColor: Colors.green,
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Agregar',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.onPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
