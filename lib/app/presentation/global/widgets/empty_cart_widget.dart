import 'package:flutter/material.dart';
import '../colors.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícono con animación sutil
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(60),
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 60,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 32),
            // Título
            Text(
              'Tu carrito está vacío...',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Descripción mejorada
            Text(
              'Agrega algunos productos para comenzar tu compra y disfruta de nuestras ofertas especiales',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // Botón call-to-action
            ElevatedButton.icon(
              onPressed: () {
                // Cambiar a pestaña Home
                final navigator = Navigator.of(context);
                navigator.popUntil((route) => route.isFirst);
              },
              icon: const Icon(Icons.shopping_bag_outlined),
              label: const Text('Explorar productos'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
