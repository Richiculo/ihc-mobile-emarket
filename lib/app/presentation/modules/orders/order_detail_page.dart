import 'package:flutter/material.dart';
import '../../global/colors.dart';
import '../../../domain/models/order.dart';
import './order_tracking_page.dart';

class OrderDetailPage extends StatelessWidget {
  final Order order;

  const OrderDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Pedido ${order.id}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        actions: [
          if (order.status == OrderStatus.inProgress ||
              order.status == OrderStatus.preparing ||
              order.status == OrderStatus.confirmed)
            IconButton(
              icon: const Icon(Icons.track_changes),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderTrackingPage(order: order),
                  ),
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            _buildStatusCard(),

            const SizedBox(height: 20),

            // Order Info
            _buildOrderInfo(),

            const SizedBox(height: 20),

            // Items
            _buildItemsList(),

            const SizedBox(height: 20),

            // Delivery Address
            _buildDeliveryAddress(),

            const SizedBox(height: 20),

            // Payment Info
            _buildPaymentInfo(),

            const SizedBox(height: 20),

            // Summary
            _buildOrderSummary(),

            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(context),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      width: double.infinity, // ✅ Asegurar que tome todo el ancho
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: order.status.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: order.status.color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // ✅ Centrar verticalmente
        crossAxisAlignment:
            CrossAxisAlignment.center, // ✅ Centrar horizontalmente
        mainAxisSize: MainAxisSize.min, // ✅ Tamaño mínimo necesario
        children: [
          // ✅ Centrar el ícono específicamente
          Center(
            child: Icon(order.status.icon, size: 48, color: order.status.color),
          ),
          const SizedBox(height: 12),

          // ✅ Centrar el título
          Center(
            child: Text(
              order.status.label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: order.status.color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 4),

          // ✅ Centrar la descripción
          Center(
            child: Text(
              order.statusDescription,
              style: TextStyle(fontSize: 14, color: order.status.color),
              textAlign: TextAlign.center,
            ),
          ),

          if (order.estimatedDelivery != null &&
              order.status == OrderStatus.inProgress) ...[
            const SizedBox(height: 12),

            // ✅ El tiempo estimado ya estaba bien centrado
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Tiempo estimado: 25 minutos',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: order.status.color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Información del Pedido',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildInfoRow('Fecha del pedido', order.formattedOrderDate),
          _buildInfoRow('ID del pedido', order.id),
          if (order.trackingCode != null)
            _buildInfoRow('Código de seguimiento', order.trackingCode!),
          if (order.estimatedDelivery != null)
            _buildInfoRow(
              'Entrega estimada',
              order.formattedEstimatedDelivery!,
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Productos (${order.items.length})',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ...order.items.map((item) => _buildItemRow(item)).toList(),
        ],
      ),
    );
  }

  Widget _buildItemRow(dynamic item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // Imagen del producto
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item.product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.surfaceVariant,
                    child: Icon(
                      Icons.image_not_supported,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Info del producto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Cantidad: ${item.quantity}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Precio
          Text(
            'Bs ${(item.product.price * item.quantity).toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddress() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Dirección de Entrega',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            order.deliveryAddress.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            order.deliveryAddress.formattedAddress,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.payment, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Método de Pago',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            order.paymentMethod ?? 'No especificado',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resumen del Pedido',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow('Subtotal', order.formattedSubtotal),
          _buildSummaryRow('Envío', order.formattedShipping),
          const Divider(),
          _buildSummaryRow('Total', order.formattedTotal, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isTotal ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Repetir pedido
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${order.items.length} productos agregados al carrito',
                    ),
                    backgroundColor: AppColors.success,
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
                  const Icon(Icons.refresh, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Repetir Pedido',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Rastrear o Contactar
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (order.status == OrderStatus.inProgress ||
                    order.status == OrderStatus.preparing ||
                    order.status == OrderStatus.confirmed) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderTrackingPage(order: order),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Función de soporte próximamente'),
                      backgroundColor: AppColors.info,
                    ),
                  );
                }
              },
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
                  Icon(
                    order.status == OrderStatus.delivered ||
                            order.status == OrderStatus.cancelled
                        ? Icons.support_agent
                        : Icons.track_changes,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    order.status == OrderStatus.delivered ||
                            order.status == OrderStatus.cancelled
                        ? 'Contactar'
                        : 'Rastrear',
                    style: const TextStyle(
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
    );
  }
}
