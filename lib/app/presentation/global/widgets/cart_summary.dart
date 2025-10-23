import 'package:flutter/material.dart';
import '../../../data/services/local/cart_service.dart';
import '../colors.dart';

class CartSummary extends StatefulWidget {
  final VoidCallback onCheckout;
  final VoidCallback onClearCart;

  const CartSummary({
    super.key,
    required this.onCheckout,
    required this.onClearCart,
  });

  @override
  State<CartSummary> createState() => _CartSummaryState();
}

class _CartSummaryState extends State<CartSummary>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header siempre visible con total y botón expandir
          _buildHeader(),

          // Contenido desplegable
          SizeTransition(
            sizeFactor: _slideAnimation,
            child: _buildExpandedContent(),
          ),

          // Botones siempre visibles
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return GestureDetector(
      onTap: _toggleExpanded,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: ListenableBuilder(
          listenable: CartService(),
          builder: (context, child) {
            final cart = CartService();

            return Row(
              children: [
                // Icono del carrito con cantidad
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        cart.itemCount.toString(),
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // Total y descripción
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        cart.formattedTotal,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Indicador de expansión
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    color: AppColors.textSecondary,
                    size: 24,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Línea divisora
          Container(
            height: 1,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(color: AppColors.surfaceVariant),
          ),

          // Desglose detallado
          ListenableBuilder(
            listenable: CartService(),
            builder: (context, child) {
              final cart = CartService();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título del desglose
                  Text(
                    'Resumen del Pedido',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Subtotal
                  _SummaryRow(
                    label: 'Subtotal (${cart.itemCount} productos)',
                    value: cart.formattedSubtotal,
                    isRegular: true,
                  ),
                  const SizedBox(height: 12),

                  // Envío
                  _SummaryRow(
                    label: 'Envío',
                    value: cart.formattedShipping,
                    isRegular: true,
                    isSpecial: cart.shipping == 0,
                  ),

                  // Mensaje de envío gratis si aplica
                  if (cart.shipping == 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '¡Envío gratis por compra mayor a Bs 50!',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Botón proceder al pago
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onCheckout,
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
                  Icon(Icons.payment, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Proceder al pago',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Botón vaciar carrito (solo visible cuando está expandido)
          if (_isExpanded)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: widget.onClearCart,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                  side: BorderSide(color: AppColors.surfaceVariant),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete_outline, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Vaciar Carrito',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isRegular;
  final bool isSpecial;

  const _SummaryRow({
    required this.label,
    required this.value,
    required this.isRegular,
    this.isSpecial = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSpecial ? Colors.green : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
