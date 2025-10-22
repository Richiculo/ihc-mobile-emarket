import 'package:flutter/material.dart';
import '../colors.dart';

class ProfileActionsSection extends StatelessWidget {
  const ProfileActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Sección de preferencias
        _ActionCard(
          title: 'Preferencias',
          icon: Icons.tune,
          actions: [
            _ActionItem(
              icon: Icons.notifications,
              title: 'Notificaciones',
              subtitle: 'Gestionar alertas y avisos',
              onTap: () => _showDemoMessage(context, 'Notificaciones'),
            ),
            _ActionItem(
              icon: Icons.language,
              title: 'Idioma',
              subtitle: 'Español',
              onTap: () => _showDemoMessage(context, 'Cambio de idioma'),
            ),
            _ActionItem(
              icon: Icons.dark_mode,
              title: 'Tema',
              subtitle: 'Claro',
              onTap: () => _showDemoMessage(context, 'Cambio de tema'),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Sección de ayuda
        _ActionCard(
          title: 'Soporte',
          icon: Icons.help,
          actions: [
            _ActionItem(
              icon: Icons.help_center,
              title: 'Centro de ayuda',
              subtitle: 'Preguntas frecuentes',
              onTap: () => _showDemoMessage(context, 'Centro de ayuda'),
            ),
            _ActionItem(
              icon: Icons.contact_support,
              title: 'Contactanos',
              subtitle: 'Envía tus consultas',
              onTap: () => _showDemoMessage(context, 'Contacto'),
            ),
            _ActionItem(
              icon: Icons.star_rate,
              title: 'Calificar app',
              subtitle: 'Ayúdanos a mejorar',
              onTap: () => _showDemoMessage(context, 'Calificación'),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Sección de cuenta
        _ActionCard(
          title: 'Cuenta',
          icon: Icons.account_circle,
          actions: [
            _ActionItem(
              icon: Icons.privacy_tip,
              title: 'Privacidad',
              subtitle: 'Términos y condiciones',
              onTap: () => _showDemoMessage(context, 'Privacidad'),
            ),
            _ActionItem(
              icon: Icons.info,
              title: 'Acerca de',
              subtitle: 'Versión 1.0.0 - Demo',
              onTap: () => _showAboutDialog(context),
            ),
          ],
        ),
      ],
    );
  }

  // Mensaje de demo
  void _showDemoMessage(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.info, color: AppColors.onInfo, size: 20),
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

  // Diálogo informativo sobre la app
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Row(
              children: [
                Icon(Icons.shopping_bag, color: AppColors.primary),
                const SizedBox(width: 8),
                const Text('YeskiMarket'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Aplicación de e-commerce'),
                const SizedBox(height: 8),
                Text(
                  'Versión: 1.0.0 (Demo)',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Desarrollado para la materia de Interacción Hombre Computadora',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ],
          ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<_ActionItem> actions;

  const _ActionCard({
    required this.title,
    required this.icon,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          // Actions
          ...actions.map((action) => action).toList(),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.textSecondary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
