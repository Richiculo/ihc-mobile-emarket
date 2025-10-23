import 'package:flutter/material.dart';
import '../../../domain/models/checkout.dart';
import '../colors.dart';

class CheckoutStepPersonalInfo extends StatefulWidget {
  final CheckoutData initialData;
  final Function(CheckoutData) onContinue;

  const CheckoutStepPersonalInfo({
    super.key,
    required this.initialData,
    required this.onContinue,
  });

  @override
  State<CheckoutStepPersonalInfo> createState() =>
      _CheckoutStepPersonalInfoState();
}

class _CheckoutStepPersonalInfoState extends State<CheckoutStepPersonalInfo> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(
      text: widget.initialData.firstName,
    );
    _lastNameController = TextEditingController(
      text: widget.initialData.lastName,
    );
    _emailController = TextEditingController(text: widget.initialData.email);
    _phoneController = TextEditingController(text: widget.initialData.phone);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
                // Mensaje informativo
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.info.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.info.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.info, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Si cuenta con alguna compra, se rellenarán los datos automáticamente con la información del último pedido.',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.info,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Título de sección
                Text(
                  'Información Personal',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 24),

                // Formulario
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Nombre
                      _buildTextField(
                        controller: _firstNameController,
                        label: 'Nombre *',
                        validator:
                            (value) =>
                                value?.isEmpty == true
                                    ? 'El nombre es requerido'
                                    : null,
                      ),

                      const SizedBox(height: 16),

                      // Apellido
                      _buildTextField(
                        controller: _lastNameController,
                        label: 'Apellido *',
                        validator:
                            (value) =>
                                value?.isEmpty == true
                                    ? 'El apellido es requerido'
                                    : null,
                      ),

                      const SizedBox(height: 16),

                      // Email
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email *',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value?.isEmpty == true)
                            return 'El email es requerido';
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value!)) {
                            return 'Ingresa un email válido';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Teléfono
                      _buildTextField(
                        controller: _phoneController,
                        label: 'Teléfono *',
                        keyboardType: TextInputType.phone,
                        validator:
                            (value) =>
                                value?.isEmpty == true
                                    ? 'El teléfono es requerido'
                                    : null,
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
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
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: const Text(
                'Continuar a Dirección',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: label.replaceAll(' *', ''),
            hintStyle: TextStyle(color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.surfaceVariant,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.error),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  void _handleContinue() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedData = CheckoutData(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        selectedAddress: widget.initialData.selectedAddress,
        paymentMethod: widget.initialData.paymentMethod,
        cardNumber: widget.initialData.cardNumber,
        cardHolder: widget.initialData.cardHolder,
        expiryDate: widget.initialData.expiryDate,
        cvv: widget.initialData.cvv,
      );

      widget.onContinue(updatedData);
    }
  }
}
