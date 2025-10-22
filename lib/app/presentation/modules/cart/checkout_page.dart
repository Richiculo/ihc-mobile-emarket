import 'package:flutter/material.dart';
import '../../../data/services/local/checkout_service.dart';
import '../../../data/services/local/cart_service.dart';
import '../../../domain/models/checkout.dart';
import '../../global/colors.dart';
import '../../global/widgets/checkout_progress_indicator.dart';
import '../../global/widgets/checkout_step_personal_info.dart';
import '../../global/widgets/checkout_step_delivery.dart';
import '../../global/widgets/checkout_step_payment.dart';
import './checkout_succes_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late CheckoutService _checkoutService;
  late CheckoutData _formData;

  @override
  void initState() {
    super.initState();
    _checkoutService = CheckoutService();
    _formData = _checkoutService.initializeFromProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Finalizar Compra',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _handleBackPressed(),
        ),
      ),
      body: ListenableBuilder(
        listenable: _checkoutService,
        builder: (context, child) {
          return Column(
            children: [
              // Progress Indicator
              CheckoutProgressIndicator(
                currentStep: _checkoutService.currentStep,
              ),

              // Content
              Expanded(child: _buildStepContent()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_checkoutService.currentStep) {
      case CheckoutStep.personalInfo:
        return CheckoutStepPersonalInfo(
          initialData: _formData,
          onContinue: (data) {
            setState(() => _formData = data);
            _checkoutService.nextStep();
          },
        );
      case CheckoutStep.deliveryAddress:
        return CheckoutStepDelivery(
          initialData: _formData,
          onContinue: (data) {
            setState(() => _formData = data);
            _checkoutService.nextStep();
          },
          onBack: () => _checkoutService.previousStep(),
        );
      case CheckoutStep.paymentMethod:
        return CheckoutStepPayment(
          initialData: _formData,
          onComplete: _completeCheckout,
          onBack: () => _checkoutService.previousStep(),
        );
    }
  }

  void _handleBackPressed() {
    if (_checkoutService.currentStep == CheckoutStep.personalInfo) {
      Navigator.pop(context);
    } else {
      _checkoutService.previousStep();
    }
  }

  void _completeCheckout(CheckoutData finalData) {
    // Simular proceso de pago
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _buildProcessingDialog(),
    );

    // Simular delay de procesamiento
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Cerrar dialog de procesamiento

      // Limpiar carrito
      CartService().clear();

      // Resetear checkout
      _checkoutService.reset();

      // Navegar a pantalla de éxito
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CheckoutSuccessPage()),
      );
    });
  }

  Widget _buildProcessingDialog() {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: AppColors.primary),
          const SizedBox(height: 16),
          Text(
            'Procesando tu pedido...',
            style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
