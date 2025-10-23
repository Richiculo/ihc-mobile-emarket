import 'package:flutter/material.dart';
import '../../../domain/models/cart_item.dart';
import '../colors.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.cartItem,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Imagen del producto
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              cartItem.product.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: AppColors.surfaceVariant,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.image_not_supported,
                    color: AppColors.textSecondary,
                    size: 24,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          // Info del producto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título y botón eliminar
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        cartItem.product.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: onRemove,
                      icon: Icon(
                        Icons.delete_outline,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Categoría o descripción
                Text(
                  'Recomendado', // O cartItem.product.category
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                // Precio y controles de cantidad
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Precio
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartItem.product.formattedPrice,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Subtotal: ${cartItem.formattedTotalPrice}',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    // Controles de cantidad
                    Row(
                      children: [
                        _QuantityButton(
                          icon: Icons.remove,
                          onPressed:
                              cartItem.quantity > 1
                                  ? () =>
                                      onQuantityChanged(cartItem.quantity - 1)
                                  : null,
                        ),
                        Container(
                          width: 40,
                          height: 32,
                          alignment: Alignment.center,
                          child: Text(
                            cartItem.quantity.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        _QuantityButton(
                          icon: Icons.add,
                          onPressed:
                              () => onQuantityChanged(cartItem.quantity + 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _QuantityButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(
          color:
              onPressed != null ? AppColors.primary : AppColors.surfaceVariant,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 16,
          color:
              onPressed != null ? AppColors.primary : AppColors.textSecondary,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
