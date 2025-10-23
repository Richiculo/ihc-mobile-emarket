import 'package:flutter/material.dart';
import '../colors.dart';

class EmptyOrdersWidget extends StatelessWidget {
  final VoidCallback? onStartShopping;

  const EmptyOrdersWidget({super.key, required this.onStartShopping});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícono de pedidos vacío
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(60),
                border: Border.all(color: AppColors.border, width: 2),
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 60,
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 24),

            // Título
            Text(
              'No tienes pedidos aún',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Descripción
            Text(
              'Cuando realices tu primera compra,\npodrás ver el seguimiento aquí',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // Botón empezar a comprar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onStartShopping,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_bag_outlined, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'Empezar a Comprar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Botón secundario
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Navegar a categorías o ofertas
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Explora nuestras categorías'),
                      backgroundColor: AppColors.info,
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.category_outlined, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'Ver Categorías',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
