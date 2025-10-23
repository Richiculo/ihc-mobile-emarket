import 'package:flutter/material.dart';
import 'user.dart';

enum CheckoutStep {
  personalInfo(1, 'Información Personal', 'Datos de contacto'),
  deliveryAddress(2, 'Dirección de Envío', 'Donde entregar'),
  paymentMethod(3, 'Método de Pago', 'Como pagar');

  const CheckoutStep(this.number, this.title, this.subtitle);
  final int number;
  final String title;
  final String subtitle;
}

enum PaymentMethod {
  creditCard('Tarjeta de Crédito/Débito', Icons.credit_card),
  cashOnDelivery('Pago contra Entrega', Icons.local_shipping);

  const PaymentMethod(this.label, this.icon);
  final String label;
  final IconData icon;
}

class CheckoutData {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final Address selectedAddress;
  final PaymentMethod paymentMethod;
  final String? cardNumber;
  final String? cardHolder;
  final String? expiryDate;
  final String? cvv;

  const CheckoutData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.selectedAddress,
    required this.paymentMethod,
    this.cardNumber,
    this.cardHolder,
    this.expiryDate,
    this.cvv,
  });
}
