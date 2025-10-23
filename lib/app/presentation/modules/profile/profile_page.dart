import 'package:flutter/material.dart';
import '../../../data/services/local/user_service.dart';
import '../../global/colors.dart';
import '../../global/widgets/profile_header.dart';
import '../../global/widgets/profile_info_section.dart';
import '../../global/widgets/address_section.dart';
import '../../global/widgets/profile_actions_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          },
        ),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: ListenableBuilder(
        listenable: UserService(),
        builder: (context, child) {
          final user = UserService().currentUser;

          if (user == null) {
            return const Center(child: Text('No hay usuario logueado'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Header con avatar y nombre
                ProfileHeader(user: user),

                const SizedBox(height: 24),

                // Información personal
                ProfileInfoSection(user: user),

                const SizedBox(height: 16),

                // Direcciones
                AddressSection(user: user),

                const SizedBox(height: 16),

                // Acciones adicionales
                const ProfileActionsSection(),

                const SizedBox(height: 80), // Espacio para bottom navigation
              ],
            ),
          );
        },
      ),
    );
  }
}
