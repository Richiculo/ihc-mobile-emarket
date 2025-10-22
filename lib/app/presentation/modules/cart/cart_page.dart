import 'package:flutter/material.dart';
import '../../../data/services/local/cart_service.dart';
import '../../global/colors.dart';
import '../../global/widgets/cart_item_card.dart';
import '../../global/widgets/cart_summary.dart';
import '../../global/widgets/empty_cart_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Carrito',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Badge con cantidad de items
          ListenableBuilder(
            listenable: CartService(),
            builder: (context, child) {
              final cart = CartService();
              if (cart.isEmpty) return const SizedBox.shrink();

              return Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.onPrimary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${cart.itemCount} Productos',
                  style: TextStyle(
                    color: AppColors.onPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: CartService(),
        builder: (context, child) {
          final cart = CartService();

          if (cart.isEmpty) {
            return const EmptyCartWidget();
          }

          return Column(
            children: [
              // Lista de productos
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    return CartItemCard(
                      cartItem: cart.items[index],
                      onQuantityChanged: (quantity) {
                        cart.updateQuantity(
                          cart.items[index].product.id,
                          quantity,
                        );
                      },
                      onRemove: () {
                        cart.removeProduct(cart.items[index].product.id);
                      },
                    );
                  },
                ),
              ),
              // Resumen y botones
              CartSummary(
                onCheckout: () {
                  // TODO: Implementar checkout
                  _showCheckoutDialog(context);
                },
                onClearCart: () {
                  _showClearCartDialog(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Proceder al pago'),
            content: const Text(
              'Esta funcionalidad se implementará próximamente.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Vaciar carrito'),
            content: const Text(
              '¿Estás seguro de que quieres eliminar todos los productos?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  CartService().clear();
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                child: const Text('Vaciar'),
              ),
            ],
          ),
    );
  }
}
