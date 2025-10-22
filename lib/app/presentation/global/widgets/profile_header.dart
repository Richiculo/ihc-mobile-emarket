import 'package:flutter/material.dart';
import '../../../domain/models/user.dart';
import '../colors.dart';

class ProfileHeader extends StatelessWidget {
  final User user;

  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
        children: [
          // Avatar
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child:
                    user.profileImage != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(38),
                          child: Image.network(
                            user.profileImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                        : Center(
                          child: Text(
                            user.initials,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
              ),
              // Botón editar avatar
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.surface, width: 2),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 16,
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Nombre y saludo
          Text(
            user.fullName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            '¡Hola ${user.firstName}! 👋',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),

          const SizedBox(height: 16),

          // Badges de verificación
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (user.isEmailVerified)
                _VerificationBadge(
                  icon: Icons.email,
                  label: 'Email verificado',
                  color: AppColors.success,
                ),
              if (user.isEmailVerified && user.isPhoneVerified)
                const SizedBox(width: 12),
              if (user.isPhoneVerified)
                _VerificationBadge(
                  icon: Icons.phone,
                  label: 'Teléfono verificado',
                  color: AppColors.info,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VerificationBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _VerificationBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
