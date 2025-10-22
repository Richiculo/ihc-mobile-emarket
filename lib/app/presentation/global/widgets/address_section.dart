import 'package:flutter/material.dart';
import '../../../domain/models/user.dart';
import '../colors.dart';

class AddressSection extends StatelessWidget {
  final User user;

  const AddressSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título de sección con botón agregar
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.location_on,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Mis direcciones',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => _showAddAddressDialog(context),
                icon: Icon(Icons.add_circle, color: AppColors.primary),
                tooltip: 'Agregar dirección',
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Lista de direcciones
          if (user.addresses.isEmpty)
            _EmptyAddresses()
          else
            Column(
              children:
                  user.addresses.map((address) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _AddressCard(
                        address: address,
                        onEdit: () => _showEditAddressDialog(context, address),
                        onDelete:
                            () => _showDeleteAddressDialog(context, address),
                      ),
                    );
                  }).toList(),
            ),
        ],
      ),
    );
  }

  void _showAddAddressDialog(BuildContext context) {
    _showNotImplemented(context, 'Agregar dirección');
  }

  void _showEditAddressDialog(BuildContext context, Address address) {
    _showNotImplemented(context, 'Editar dirección');
  }

  void _showDeleteAddressDialog(BuildContext context, Address address) {
    _showNotImplemented(context, 'Eliminar dirección');
  }

  void _showNotImplemented(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature: Funcionalidad de demostración'),
        backgroundColor: AppColors.info,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final Address address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _AddressCard({
    required this.address,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            address.isDefault
                ? AppColors.primary.withOpacity(0.05)
                : AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border:
            address.isDefault
                ? Border.all(color: AppColors.primary.withOpacity(0.3))
                : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con label y badges
          Row(
            children: [
              Text(
                address.label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              if (address.isDefault)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Predeterminada',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              const Spacer(),
              // Botones de acción
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') onEdit();
                  if (value == 'delete') onDelete();
                },
                itemBuilder:
                    (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 16),
                            SizedBox(width: 8),
                            Text('Editar'),
                          ],
                        ),
                      ),
                      if (!address.isDefault)
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                size: 16,
                                color: AppColors.error,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Eliminar',
                                style: TextStyle(color: AppColors.error),
                              ),
                            ],
                          ),
                        ),
                    ],
                child: Icon(Icons.more_vert, color: AppColors.textSecondary),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Dirección completa
          Text(
            address.formattedAddress,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyAddresses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.surfaceVariant,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Icon(Icons.location_off, size: 48, color: AppColors.textSecondary),
          const SizedBox(height: 12),
          Text(
            'Sin direcciones guardadas',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Agrega una dirección para facilitar tus compras',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
