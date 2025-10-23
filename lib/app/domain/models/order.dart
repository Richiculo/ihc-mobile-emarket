import 'package:flutter/material.dart';
import '../../presentation/global/colors.dart';
import 'cart_item.dart';
import 'user.dart';

enum OrderStatus {
  pending('Pendiente', 'order_pending', 'pending'),
  confirmed('Confirmado', 'order_confirmed', 'confirmed'),
  preparing('Preparando', 'order_preparing', 'preparing'),
  inProgress('En Camino', 'order_in_progress', 'in_progress'),
  delivered('Entregado', 'order_delivered', 'delivered'),
  cancelled('Cancelado', 'order_cancelled', 'cancelled');

  const OrderStatus(this.label, this.key, this.value);

  final String label;
  final String key;
  final String value;

  IconData get icon {
    switch (this) {
      case OrderStatus.pending:
        return Icons.schedule;
      case OrderStatus.confirmed:
        return Icons.check_circle_outline;
      case OrderStatus.preparing:
        return Icons.restaurant;
      case OrderStatus.inProgress:
        return Icons.local_shipping;
      case OrderStatus.delivered:
        return Icons.check_circle;
      case OrderStatus.cancelled:
        return Icons.cancel;
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.pending:
        return AppColors.pending;
      case OrderStatus.confirmed:
        return AppColors.confirmed;
      case OrderStatus.preparing:
        return AppColors.preparing;
      case OrderStatus.inProgress:
        return AppColors.inProgress;
      case OrderStatus.delivered:
        return AppColors.delivered;
      case OrderStatus.cancelled:
        return AppColors.cancelled;
    }
  }

  Color get onColor {
    switch (this) {
      case OrderStatus.pending:
        return AppColors.onPending;
      case OrderStatus.confirmed:
        return AppColors.onConfirmed;
      case OrderStatus.preparing:
        return AppColors.onPreparing;
      case OrderStatus.inProgress:
        return AppColors.onProgress;
      case OrderStatus.delivered:
        return AppColors.onDelivered;
      case OrderStatus.cancelled:
        return AppColors.onCancelled;
    }
  }
}

class Order {
  final String id;
  final DateTime orderDate;
  final List<CartItem> items;
  final Address deliveryAddress;
  final OrderStatus status;
  final double subtotal;
  final double shipping;
  final double total;
  final String? paymentMethod;
  final DateTime? estimatedDelivery;
  final String? trackingCode;
  final List<OrderUpdate> updates;

  const Order({
    required this.id,
    required this.orderDate,
    required this.items,
    required this.deliveryAddress,
    required this.status,
    required this.subtotal,
    required this.shipping,
    required this.total,
    this.paymentMethod,
    this.estimatedDelivery,
    this.trackingCode,
    this.updates = const [],
  });

  String get formattedSubtotal => 'Bs ${subtotal.toStringAsFixed(2)}';
  String get formattedShipping =>
      shipping == 0 ? 'Gratis' : 'Bs ${shipping.toStringAsFixed(2)}';
  String get formattedTotal => 'Bs ${total.toStringAsFixed(2)}';

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  String get formattedOrderDate {
    final months = [
      'Ene',
      'Feb',
      'Mar',
      'Abr',
      'May',
      'Jun',
      'Jul',
      'Ago',
      'Sep',
      'Oct',
      'Nov',
      'Dic',
    ];
    return '${orderDate.day} ${months[orderDate.month - 1]} ${orderDate.year}';
  }

  String? get formattedEstimatedDelivery {
    if (estimatedDelivery == null) return null;
    final months = [
      'Ene',
      'Feb',
      'Mar',
      'Abr',
      'May',
      'Jun',
      'Jul',
      'Ago',
      'Sep',
      'Oct',
      'Nov',
      'Dic',
    ];
    return '${estimatedDelivery!.day} ${months[estimatedDelivery!.month - 1]} ${estimatedDelivery!.year}';
  }

  String get statusDescription {
    switch (status) {
      case OrderStatus.pending:
        return 'Tu pedido está pendiente de confirmación';
      case OrderStatus.confirmed:
        return 'Pedido confirmado y en proceso';
      case OrderStatus.preparing:
        return 'Tu pedido está siendo preparado';
      case OrderStatus.inProgress:
        return 'Tu pedido está en camino';
      case OrderStatus.delivered:
        return 'Pedido entregado exitosamente';
      case OrderStatus.cancelled:
        return 'Pedido cancelado';
    }
  }
}

class OrderUpdate {
  final DateTime timestamp;
  final OrderStatus status;
  final String message;
  final String? location;

  const OrderUpdate({
    required this.timestamp,
    required this.status,
    required this.message,
    this.location,
  });

  String get formattedTime {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  String get formattedDate {
    final months = [
      'Ene',
      'Feb',
      'Mar',
      'Abr',
      'May',
      'Jun',
      'Jul',
      'Ago',
      'Sep',
      'Oct',
      'Nov',
      'Dic',
    ];
    return '${timestamp.day} ${months[timestamp.month - 1]} ${timestamp.year}';
  }

  String get formattedDateTime {
    return '${formattedDate} a las ${formattedTime}';
  }
}
