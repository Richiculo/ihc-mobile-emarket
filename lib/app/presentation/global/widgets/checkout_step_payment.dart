import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../domain/models/checkout.dart';
import '../../../data/services/local/cart_service.dart';
import '../colors.dart';

class CheckoutStepPayment extends StatefulWidget {
  final CheckoutData initialData;
  final Function(CheckoutData) onComplete;
  final VoidCallback onBack;

  const CheckoutStepPayment({
    super.key,
    required this.initialData,
    required this.onComplete,
    required this.onBack,
  });

  @override
  State<CheckoutStepPayment> createState() => _CheckoutStepPaymentState();
}

class _CheckoutStepPaymentState extends State<CheckoutStepPayment> {
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cashOnDelivery;
  final _formKey = GlobalKey<FormState>();

  // Controladores para tarjeta
  final _cardHolderController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedPaymentMethod = widget.initialData.paymentMethod;
    _cardHolderController.text = widget.initialData.cardHolder ?? '';
    _cardNumberController.text = widget.initialData.cardNumber ?? '';
    _expiryController.text = widget.initialData.expiryDate ?? '';
    _cvvController.text = widget.initialData.cvv ?? '';
  }

  @override
  void dispose() {
    _cardHolderController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Resumen del pedido más compacto
                _buildCompactOrderSummary(),

                const SizedBox(height: 24),

                // Título de métodos de pago
                Text(
                  'Método de Pago',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Selecciona un método de pago',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 20),

                _buildImprovedPaymentMethods(),

                const SizedBox(height: 20),

                if (_selectedPaymentMethod == PaymentMethod.creditCard)
                  _buildCreditCardForm(),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.all(24),
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
              // Botón atrás
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onBack,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    side: BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Atrás',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Botón finalizar
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: _handleComplete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: AppColors.onSuccess,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.payment, size: 20),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          _selectedPaymentMethod == PaymentMethod.creditCard
                              ? 'Realizar pago vía Libelula'
                              : 'Finalizar Pedido',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactOrderSummary() {
    final cart = CartService();

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
          // Subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'subtotal (${cart.itemCount} productos)',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              Text(
                cart.formattedSubtotal,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Envío
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Envío',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              Text(
                cart.shipping == 0 ? 'Gratis' : cart.formattedShipping,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color:
                      cart.shipping == 0
                          ? AppColors.success
                          : AppColors.textPrimary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Línea divisora
          Container(height: 1, color: AppColors.border),

          const SizedBox(height: 12),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                cart.formattedTotal,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImprovedPaymentMethods() {
    return Column(
      children:
          PaymentMethod.values.map((method) {
            final isSelected = _selectedPaymentMethod == method;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () => setState(() => _selectedPaymentMethod = method),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Radio button
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                isSelected
                                    ? AppColors.primary
                                    : AppColors.border,
                            width: 2,
                          ),
                          color:
                              isSelected
                                  ? AppColors.primary
                                  : Colors.transparent,
                        ),
                        child:
                            isSelected
                                ? Center(
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.onPrimary,
                                    ),
                                  ),
                                )
                                : null,
                      ),

                      const SizedBox(width: 16),

                      // Ícono del método
                      Icon(method.icon, color: AppColors.textPrimary, size: 24),

                      const SizedBox(width: 16),

                      // Información del método
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              method.label,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            if (method == PaymentMethod.cashOnDelivery) ...[
                              const SizedBox(height: 4),
                              Text(
                                'Pagarás en efectivo al momento de la entrega.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Total a pagar: ${CartService().formattedTotal}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.warning,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildCreditCardForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logos de tarjetas
            Row(
              children: [
                Text(
                  'Red Enlace',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                // Logos más pequeños
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Text(
                    'VISA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Text(
                    'MC',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Nombre del propietario
            _buildCardField(
              controller: _cardHolderController,
              label: 'Datos del propietario',
              validator: (value) => value?.isEmpty == true ? 'Requerido' : null,
            ),

            const SizedBox(height: 12),

            // Número de tarjeta
            _buildCardField(
              controller: _cardNumberController,
              label: 'Nro de la tarjeta:',
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
                _CardNumberFormatter(),
              ],
              validator: (value) {
                if (value?.isEmpty == true) return 'Requerido';
                if (value!.replaceAll(' ', '').length < 16)
                  return 'Mínimo 16 dígitos';
                return null;
              },
            ),

            const SizedBox(height: 12),

            // Fecha de expiración y CVV
            Row(
              children: [
                Expanded(
                  child: _buildCardField(
                    controller: _expiryController,
                    label: 'Fecha de expiración:',
                    hintText: 'MM/AA',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      _ExpiryDateFormatter(),
                    ],
                    validator:
                        (value) => value?.isEmpty == true ? 'Requerido' : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildCardField(
                    controller: _cvvController,
                    label: 'Código CCV:',
                    hintText: '***',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    validator:
                        (value) => value?.isEmpty == true ? 'Requerido' : null,
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardField({
    required TextEditingController controller,
    required String label,
    String? hintText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText ?? label,
            hintStyle: TextStyle(color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.surfaceVariant,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.error),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  void _handleComplete() {
    // Validar formulario de tarjeta si está seleccionado
    if (_selectedPaymentMethod == PaymentMethod.creditCard) {
      if (!(_formKey.currentState?.validate() ?? false)) {
        return;
      }
    }

    final finalData = CheckoutData(
      firstName: widget.initialData.firstName,
      lastName: widget.initialData.lastName,
      email: widget.initialData.email,
      phone: widget.initialData.phone,
      selectedAddress: widget.initialData.selectedAddress,
      paymentMethod: _selectedPaymentMethod,
      cardNumber:
          _selectedPaymentMethod == PaymentMethod.creditCard
              ? _cardNumberController.text
              : null,
      cardHolder:
          _selectedPaymentMethod == PaymentMethod.creditCard
              ? _cardHolderController.text
              : null,
      expiryDate:
          _selectedPaymentMethod == PaymentMethod.creditCard
              ? _expiryController.text
              : null,
      cvv:
          _selectedPaymentMethod == PaymentMethod.creditCard
              ? _cvvController.text
              : null,
    );

    widget.onComplete(finalData);
  }
}

// Formateadores (sin cambios)
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i == 2) buffer.write('/');
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
