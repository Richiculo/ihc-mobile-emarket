import 'package:flutter/material.dart';
import '../../../domain/models/checkout.dart';
import '../../../domain/models/user.dart';
import '../../../data/services/local/user_service.dart';
import '../colors.dart';
import 'mock_map_widget.dart';

class CheckoutStepDelivery extends StatefulWidget {
  final CheckoutData initialData;
  final Function(CheckoutData) onContinue;
  final VoidCallback onBack;

  const CheckoutStepDelivery({
    super.key,
    required this.initialData,
    required this.onContinue,
    required this.onBack,
  });

  @override
  State<CheckoutStepDelivery> createState() => _CheckoutStepDeliveryState();
}

class _CheckoutStepDeliveryState extends State<CheckoutStepDelivery> {
  late Address _selectedAddress;
  bool _useMapSelection = false;

  @override
  void initState() {
    super.initState();
    _selectedAddress = widget.initialData.selectedAddress;
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
                // Título de sección
                Text(
                  'Dirección de Envío',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 24),

                // Toggle principal: Direcciones guardadas vs Mapa
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      // Opción: Mis direcciones
                      GestureDetector(
                        onTap: () => setState(() => _useMapSelection = false),
                        child: Row(
                          children: [
                            Icon(
                              _useMapSelection
                                  ? Icons.radio_button_off
                                  : Icons.radio_button_on,
                              color:
                                  _useMapSelection
                                      ? AppColors.textSecondary
                                      : AppColors.primary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Usar mis direcciones guardadas',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Opción: Seleccionar en mapa
                      GestureDetector(
                        onTap: () => setState(() => _useMapSelection = true),
                        child: Row(
                          children: [
                            Icon(
                              _useMapSelection
                                  ? Icons.radio_button_on
                                  : Icons.radio_button_off,
                              color:
                                  _useMapSelection
                                      ? AppColors.primary
                                      : AppColors.textSecondary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Seleccionar ubicación en mapa',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                if (!_useMapSelection)
                  _buildAddressSelector()
                else
                  _buildMapSelection(),

                const SizedBox(height: 20),

                // Información de envío
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.success.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_shipping,
                        color: AppColors.success,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Envío gratis',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.success,
                              ),
                            ),
                            Text(
                              'Tiempo estimado: 30-45 minutos',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

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

              // Botón continuar
              Expanded(
                flex: 2,
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
                    'Continuar al Pago',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddressSelector() {
    final user = UserService().currentUser;
    final addresses = user?.addresses ?? [_selectedAddress];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selecciona una dirección:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 12),

        ...addresses.map((address) => _buildAddressCard(address)).toList(),
      ],
    );
  }

  Widget _buildAddressCard(Address address) {
    final isSelected = _selectedAddress.id == address.id;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => setState(() => _selectedAddress = address),
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
              Icon(
                isSelected ? Icons.radio_button_on : Icons.radio_button_off,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),

              const SizedBox(width: 16),

              // Información de la dirección
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          address.label,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (address.isDefault) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Principal',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address.formattedAddress,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selecciona tu ubicación:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 12),

        // Mapa
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: MockMapWidget(
              address: _selectedAddress.formattedAddress,
              onTap: () {
                setState(() {
                  // Simular selección de nueva ubicación en mapa
                  _selectedAddress = const Address(
                    id: 'map_selection',
                    label: 'Ubicación en mapa',
                    fullAddress: 'Ubicación seleccionada en el mapa',
                    city: 'Santa Cruz',
                    state: 'Santa Cruz',
                    zipCode: '00000',
                  );
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Ubicación seleccionada en el mapa'),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Dirección seleccionada del mapa
        if (_selectedAddress.id == 'map_selection')
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: AppColors.primary, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Ubicación seleccionada en el mapa',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _handleContinue() {
    final updatedData = CheckoutData(
      firstName: widget.initialData.firstName,
      lastName: widget.initialData.lastName,
      email: widget.initialData.email,
      phone: widget.initialData.phone,
      selectedAddress: _selectedAddress,
      paymentMethod: widget.initialData.paymentMethod,
      cardNumber: widget.initialData.cardNumber,
      cardHolder: widget.initialData.cardHolder,
      expiryDate: widget.initialData.expiryDate,
      cvv: widget.initialData.cvv,
    );

    widget.onContinue(updatedData);
  }
}
