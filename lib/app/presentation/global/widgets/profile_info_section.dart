import 'package:flutter/material.dart';
import '../../../domain/models/user.dart';
import '../colors.dart';

class ProfileInfoSection extends StatelessWidget {
  final User user;

  const ProfileInfoSection({super.key, required this.user});

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
          // Título de sección
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.person, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Información Personal',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Campo Nombre Completo
          _ProfileField(
            label: 'Nombre Completo',
            value: user.fullName,
            icon: Icons.badge,
            onTap: () => _showDemoMessage(context, 'Editar nombre'),
          ),

          const SizedBox(height: 16),

          // Campo Email
          _ProfileField(
            label: 'Correo',
            value: user.email,
            icon: Icons.email,
            isVerified: user.isEmailVerified,
            onTap: () => _showDemoMessage(context, 'Editar correo'),
          ),

          const SizedBox(height: 16),

          // Campo Teléfono
          _ProfileField(
            label: 'Teléfono',
            value: user.phone,
            icon: Icons.phone,
            isVerified: user.isPhoneVerified,
            onTap: () => _showDemoMessage(context, 'Editar teléfono'),
          ),

          const SizedBox(height: 16),

          // Campo Miembro desde - SIN EDITAR
          _ProfileField(
            label: 'Miembro desde',
            value: _formatMemberSince(user.createdAt),
            icon: Icons.calendar_today,
            isReadOnly: true, // No editable
          ),
        ],
      ),
    );
  }

  String _formatMemberSince(DateTime date) {
    final months = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  // Mensaje de demo
  void _showDemoMessage(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.edit, color: AppColors.onInfo, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '$feature: Funcionalidad de demostración',
                style: TextStyle(color: AppColors.onInfo),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.info,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool isVerified;
  final bool isReadOnly;
  final VoidCallback? onTap;

  const _ProfileField({
    required this.label,
    required this.value,
    required this.icon,
    this.isVerified = false,
    this.isReadOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label con verificación
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.textSecondary),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
                letterSpacing: 0.5,
              ),
            ),
            if (isVerified) ...[
              const SizedBox(width: 6),
              Icon(Icons.verified, size: 14, color: AppColors.verified),
            ],
          ],
        ),

        const SizedBox(height: 8),

        // Value container
        GestureDetector(
          onTap: isReadOnly ? null : onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:
                  isReadOnly
                      ? AppColors.surfaceVariant.withOpacity(0.5)
                      : AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          isReadOnly
                              ? AppColors.textSecondary
                              : AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (!isReadOnly)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(Icons.edit, size: 16, color: AppColors.primary),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
