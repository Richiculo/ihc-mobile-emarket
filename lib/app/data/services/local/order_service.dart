import 'package:flutter/foundation.dart';
import '../../../domain/models/order.dart';
import '../../../domain/models/cart_item.dart';
import '../../services/local/product_service.dart';
import '../../../domain/models/user.dart';

class OrdersService extends ChangeNotifier {
  static final OrdersService _instance = OrdersService._internal();
  factory OrdersService() => _instance;
  OrdersService._internal() {
    _initializeMockOrders();
  }

  List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  List<Order> getOrdersByStatus(OrderStatus status) {
    return _orders.where((order) => order.status == status).toList();
  }

  Order? getOrderById(String id) {
    try {
      return _orders.firstWhere((order) => order.id == id);
    } catch (e) {
      return null;
    }
  }

  void _initializeMockOrders() {
    final now = DateTime.now();
    final productService = ProductService();
    final defaultAddress = const Address(
      id: 'addr_1',
      label: 'Casa',
      fullAddress: 'Av. Radial 27, Calle Geminis',
      city: 'Santa Cruz',
      state: 'Santa Cruz',
      zipCode: '00000',
      isDefault: true,
    );

    _orders = [
      Order(
        id: 'ORD-001',
        orderDate: now.subtract(const Duration(hours: 2)),
        items: [
          CartItem(product: productService.getProductById('1')!, quantity: 2),
          CartItem(product: productService.getProductById('2')!, quantity: 1),
        ],
        deliveryAddress: defaultAddress,
        status: OrderStatus.inProgress,
        subtotal: 69.0, // (12*2) + 45
        shipping: 0.0,
        total: 69.0,
        paymentMethod: 'Tarjeta de Crédito',
        estimatedDelivery: now.add(const Duration(minutes: 25)),
        trackingCode: 'TRK-001-2024',
        updates: [
          OrderUpdate(
            timestamp: now.subtract(const Duration(hours: 2)),
            status: OrderStatus.confirmed,
            message: 'Pedido confirmado',
          ),
          OrderUpdate(
            timestamp: now.subtract(const Duration(hours: 1, minutes: 30)),
            status: OrderStatus.preparing,
            message: 'Tu pedido está siendo preparado',
          ),
          OrderUpdate(
            timestamp: now.subtract(const Duration(minutes: 15)),
            status: OrderStatus.inProgress,
            message: 'Pedido en camino',
            location: 'Av. Cristo Redentor, 3er Anillo',
          ),
        ],
      ),
      Order(
        id: 'ORD-002',
        orderDate: now.subtract(const Duration(days: 1)),
        items: [
          CartItem(product: productService.getProductById('4')!, quantity: 1),
          CartItem(product: productService.getProductById('3')!, quantity: 2),
        ],
        deliveryAddress: defaultAddress,
        status: OrderStatus.delivered,
        subtotal: 32.0, // 15 + (8.5*2)
        shipping: 10.0,
        total: 42.0,
        paymentMethod: 'Efectivo',
        trackingCode: 'TRK-002-2024',
        updates: [
          OrderUpdate(
            timestamp: now.subtract(const Duration(days: 1, hours: 2)),
            status: OrderStatus.confirmed,
            message: 'Pedido confirmado',
          ),
          OrderUpdate(
            timestamp: now.subtract(const Duration(days: 1, hours: 1)),
            status: OrderStatus.delivered,
            message: 'Pedido entregado exitosamente',
          ),
        ],
      ),
      Order(
        id: 'ORD-003',
        orderDate: now.subtract(const Duration(days: 3)),
        items: [
          CartItem(product: productService.getProductById('5')!, quantity: 1),
        ],
        deliveryAddress: defaultAddress,
        status: OrderStatus.delivered,
        subtotal: 35.0,
        shipping: 0.0,
        total: 35.0,
        paymentMethod: 'Tarjeta de Débito',
        trackingCode: 'TRK-003-2024',
        updates: [
          OrderUpdate(
            timestamp: now.subtract(const Duration(days: 3, hours: 1)),
            status: OrderStatus.delivered,
            message: 'Pedido entregado exitosamente',
          ),
        ],
      ),
    ];
  }
}
