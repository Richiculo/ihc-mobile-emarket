import 'package:flutter/material.dart';
import '../../global/colors.dart';
import '../../global/widgets/order_card.dart';
import '../../global/widgets/empty_orders_widget.dart';
import '../../../data/services/local/order_service.dart';
import '../../../domain/models/order.dart';
import './order_detail_page.dart';
import './order_tracking_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Mis Pedidos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: OrdersService(),
        builder: (context, child) {
          final ordersService = OrdersService();

          if (ordersService.orders.isEmpty) {
            return EmptyOrdersWidget(
              onStartShopping: () {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
              },
            );
          }

          return Column(
            children: [
              // Lista de pedidos
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: ordersService.orders.length,
                  itemBuilder: (context, index) {
                    final order = ordersService.orders[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: OrderCard(
                        order: order,
                        onTap: () => _showOrderDetail(context, order),
                        onTrack: () => _trackOrder(context, order),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Filtrar Pedidos'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  OrderStatus.values.map((status) {
                    return ListTile(
                      leading: Icon(status.icon, color: status.color),
                      title: Text(status.label),
                      onTap: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Filtro aplicado: ${status.label}'),
                            backgroundColor: AppColors.info,
                          ),
                        );
                      },
                    );
                  }).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
            ],
          ),
    );
  }

  void _showOrderDetail(BuildContext context, Order order) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderDetailPage(order: order)),
    );
  }

  void _trackOrder(BuildContext context, Order order) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderTrackingPage(order: order)),
    );
  }
}
