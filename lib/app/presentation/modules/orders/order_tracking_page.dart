import 'package:flutter/material.dart';
import '../../global/colors.dart';
import '../../global/widgets/mock_map_widget.dart';
import '../../../domain/models/order.dart';

class OrderTrackingPage extends StatelessWidget {
  final Order order;

  const OrderTrackingPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Rastrear Pedido ${order.id}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Simular actualización del estado
              _simulateStatusUpdate(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Status Header
            _buildStatusHeader(),

            // Map Section
            _buildMapSection(),

            // Progress Timeline
            _buildProgressTimeline(),

            // Order Summary
            _buildOrderSummary(),

            // Contact Info
            _buildContactInfo(),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(context),
    );
  }

  Widget _buildStatusHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [order.status.color, order.status.color.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Icon(order.status.icon, size: 48, color: order.status.onColor),
          const SizedBox(height: 12),
          Text(
            order.status.label,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: order.status.onColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            order.statusDescription,
            style: TextStyle(
              fontSize: 16,
              color: order.status.onColor.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),

          if (order.status == OrderStatus.inProgress) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: order.status.onColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: order.status.onColor.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: order.status.onColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Llega en 15-25 minutos',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: order.status.onColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    if (order.status != OrderStatus.inProgress &&
        order.status != OrderStatus.preparing) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.all(16),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // ✅ Mock Map con parámetro correcto
            MockMapWidget(
              address: order.deliveryAddress.fullAddress,
              isTracking: true,
            ),

            // Overlay con info del delivery
            if (order.status == OrderStatus.inProgress)
              Builder(
                // ✅ Agregar Builder widget para obtener context
                builder: (BuildContext context) {
                  return Positioned(
                    top: 12,
                    left: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(8),
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
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.delivery_dining,
                              color: AppColors.onPrimary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tu repartidor está en camino',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  'Carlos M. - Moto ABC-123',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _showContactDeliveryDialog(
                                context,
                              ); // ✅ Ahora context está disponible
                            },
                            icon: Icon(
                              Icons.phone,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.primary.withOpacity(
                                0.1,
                              ),
                              minimumSize: const Size(32, 32),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressTimeline() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progreso del Pedido',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          // Timeline items
          ...order.updates.asMap().entries.map((entry) {
            final index = entry.key;
            final update = entry.value;
            final isLast = index == order.updates.length - 1;
            final isCompleted = _isStatusCompleted(update.status);

            return _buildTimelineItem(
              update: update,
              isCompleted: isCompleted,
              isLast: isLast,
              isCurrent: update.status == order.status,
            );
          }).toList(),

          // Future steps
          ..._getFutureSteps().map((status) {
            return _buildTimelineItem(
              status: status,
              isCompleted: false,
              isLast: status == OrderStatus.delivered,
              isCurrent: false,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    OrderUpdate? update,
    OrderStatus? status,
    required bool isCompleted,
    required bool isLast,
    required bool isCurrent,
  }) {
    final itemStatus = update?.status ?? status!;
    final timestamp = update?.timestamp;
    final message = update?.message ?? _getDefaultMessage(itemStatus);
    final location = update?.location;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color:
                    isCompleted || isCurrent
                        ? itemStatus.color
                        : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      isCompleted || isCurrent
                          ? itemStatus.color
                          : AppColors.border,
                  width: 2,
                ),
              ),
              child: Icon(
                isCompleted
                    ? Icons.check
                    : isCurrent
                    ? itemStatus.icon
                    : itemStatus.icon,
                size: 12,
                color:
                    isCompleted || isCurrent
                        ? itemStatus.onColor
                        : AppColors.textSecondary,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color:
                    isCompleted
                        ? itemStatus.color.withOpacity(0.3)
                        : AppColors.border,
              ),
          ],
        ),

        const SizedBox(width: 12),

        // Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemStatus.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color:
                        isCompleted || isCurrent
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                  ),
                ),
                if (message.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                if (location != null) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 12,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (timestamp != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    update!.formattedDateTime,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      margin: const EdgeInsets.all(16),
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

          // Items preview
          ...order.items.take(2).map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text(
                    '${item.quantity}x',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.product.title,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          if (order.items.length > 2) ...[
            Text(
              '... y ${order.items.length - 2} productos más',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],

          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                order.formattedTotal,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.info.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(Icons.info_outline, color: AppColors.info, size: 24),
          const SizedBox(height: 8),
          Text(
            '¿Necesitas ayuda?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.info,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Contacta al soporte si tienes algún problema con tu pedido',
            style: TextStyle(fontSize: 12, color: AppColors.info),
            textAlign: TextAlign.center,
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
          // Contactar soporte
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                _showSupportDialog(context);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.info,
                side: BorderSide(color: AppColors.info),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.support_agent, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Soporte',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Llamar repartidor (solo si está en camino)
          Expanded(
            child: ElevatedButton(
              onPressed:
                  order.status == OrderStatus.inProgress
                      ? () => _showContactDeliveryDialog(context)
                      : () => _simulateStatusUpdate(context),
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
                    order.status == OrderStatus.inProgress
                        ? Icons.phone
                        : Icons.refresh,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    order.status == OrderStatus.inProgress
                        ? 'Llamar'
                        : 'Actualizar',
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

  // Helper methods
  bool _isStatusCompleted(OrderStatus status) {
    final statusOrder = [
      OrderStatus.pending,
      OrderStatus.confirmed,
      OrderStatus.preparing,
      OrderStatus.inProgress,
      OrderStatus.delivered,
    ];

    final currentIndex = statusOrder.indexOf(order.status);
    final statusIndex = statusOrder.indexOf(status);

    return statusIndex <= currentIndex;
  }

  List<OrderStatus> _getFutureSteps() {
    switch (order.status) {
      case OrderStatus.pending:
        return [
          OrderStatus.confirmed,
          OrderStatus.preparing,
          OrderStatus.inProgress,
          OrderStatus.delivered,
        ];
      case OrderStatus.confirmed:
        return [
          OrderStatus.preparing,
          OrderStatus.inProgress,
          OrderStatus.delivered,
        ];
      case OrderStatus.preparing:
        return [OrderStatus.inProgress, OrderStatus.delivered];
      case OrderStatus.inProgress:
        return [OrderStatus.delivered];
      case OrderStatus.delivered:
      case OrderStatus.cancelled:
        return [];
    }
  }

  String _getDefaultMessage(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Esperando confirmación del restaurante';
      case OrderStatus.confirmed:
        return 'Pedido confirmado, preparación iniciada';
      case OrderStatus.preparing:
        return 'Tu pedido está siendo preparado';
      case OrderStatus.inProgress:
        return 'Repartidor en camino a tu ubicación';
      case OrderStatus.delivered:
        return 'Pedido entregado exitosamente';
      case OrderStatus.cancelled:
        return 'Pedido cancelado';
    }
  }

  void _simulateStatusUpdate(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Estado actualizado'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  // ✅ Corregir el parámetro context que faltaba
  void _showContactDeliveryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (BuildContext dialogContext) => AlertDialog(
            // ✅ Usar dialogContext para evitar conflicto
            title: Row(
              children: [
                Icon(Icons.phone, color: AppColors.primary),
                const SizedBox(width: 8),
                const Text('Contactar Repartidor'),
              ],
            ),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Carlos Mendoza'),
                Text('Moto: ABC-123'),
                SizedBox(height: 12),
                Text('¿Deseas llamar al repartidor?'),
              ],
            ),
            actions: [
              TextButton(
                onPressed:
                    () => Navigator.pop(dialogContext), // ✅ Usar dialogContext
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext); // ✅ Usar dialogContext
                  ScaffoldMessenger.of(context).showSnackBar(
                    // ✅ Mantener context original para SnackBar
                    SnackBar(
                      content: const Text('Llamando al repartidor...'),
                      backgroundColor: AppColors.info,
                    ),
                  );
                },
                child: const Text('Llamar'),
              ),
            ],
          ),
    );
  }

  void _showSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (BuildContext dialogContext) => AlertDialog(
            // ✅ Mismo patrón para consistencia
            title: Row(
              children: [
                Icon(Icons.support_agent, color: AppColors.info),
                const SizedBox(width: 8),
                const Text('Soporte al Cliente'),
              ],
            ),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('¿En qué podemos ayudarte?'),
                SizedBox(height: 16),
                Text('Horarios de atención:'),
                Text('Lunes a Domingo: 8:00 - 22:00'),
              ],
            ),
            actions: [
              TextButton(
                onPressed:
                    () => Navigator.pop(dialogContext), // ✅ Usar dialogContext
                child: const Text('Cerrar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext); // ✅ Usar dialogContext
                  ScaffoldMessenger.of(context).showSnackBar(
                    // ✅ Mantener context original
                    SnackBar(
                      content: const Text('Contactando soporte...'),
                      backgroundColor: AppColors.info,
                    ),
                  );
                },
                child: const Text('Contactar'),
              ),
            ],
          ),
    );
  }
}
