import 'package:flutter/foundation.dart';
import '../../../domain/models/checkout.dart';
import '../../../domain/models/user.dart';
import 'user_service.dart';

class CheckoutService extends ChangeNotifier {
  static final CheckoutService _instance = CheckoutService._internal();
  factory CheckoutService() => _instance;
  CheckoutService._internal();

  CheckoutStep _currentStep = CheckoutStep.personalInfo;
  CheckoutData? _checkoutData;

  CheckoutStep get currentStep => _currentStep;
  CheckoutData? get checkoutData => _checkoutData;

  // Pre-llenar con datos del perfil
  CheckoutData initializeFromProfile() {
    final user = UserService().currentUser;
    return CheckoutData(
      firstName: user?.firstName ?? '',
      lastName: user?.fullName.split(' ').skip(1).join(' ') ?? '',
      email: user?.email ?? '',
      phone: user?.phone ?? '',
      selectedAddress: user?.defaultAddress ?? _getDefaultAddress(),
      paymentMethod: PaymentMethod.cashOnDelivery,
    );
  }

  Address _getDefaultAddress() {
    return const Address(
      id: 'default',
      label: 'Dirección principal',
      fullAddress: 'Av. Radial 27, Calle Geminis',
      city: 'Santa Cruz',
      state: 'Santa Cruz',
      zipCode: '00001',
      isDefault: true,
    );
  }

  void setStep(CheckoutStep step) {
    _currentStep = step;
    notifyListeners();
  }

  void nextStep() {
    switch (_currentStep) {
      case CheckoutStep.personalInfo:
        _currentStep = CheckoutStep.deliveryAddress;
        break;
      case CheckoutStep.deliveryAddress:
        _currentStep = CheckoutStep.paymentMethod;
        break;
      case CheckoutStep.paymentMethod:
        // Completar compra
        break;
    }
    notifyListeners();
  }

  void previousStep() {
    switch (_currentStep) {
      case CheckoutStep.paymentMethod:
        _currentStep = CheckoutStep.deliveryAddress;
        break;
      case CheckoutStep.deliveryAddress:
        _currentStep = CheckoutStep.personalInfo;
        break;
      case CheckoutStep.personalInfo:
        // No hacer nada, es el primer paso
        break;
    }
    notifyListeners();
  }

  void updateCheckoutData(CheckoutData data) {
    _checkoutData = data;
    notifyListeners();
  }

  void reset() {
    _currentStep = CheckoutStep.personalInfo;
    _checkoutData = null;
    notifyListeners();
  }
}
