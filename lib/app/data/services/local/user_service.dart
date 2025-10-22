import 'package:flutter/foundation.dart';
import '../../../domain/models/user.dart';

class UserService extends ChangeNotifier {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal() {
    _loadMockUser();
  }

  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  void _loadMockUser() {
    _currentUser = User(
      id: 'user_001',
      fullName: 'Richard Vargas',
      email: 'rvargasosilnaga@gmail.com',
      phone: '+591 78965432',
      addresses: [
        Address(
          id: 'addr_001',
          label: 'Casa',
          fullAddress: 'Av. Radial 27, Calle Geminis',
          city: 'Santa Cruz',
          state: 'Santa Cruz',
          zipCode: '00001',
          isDefault: true,
        ),
        Address(
          id: 'addr_002',
          label: 'Trabajo',
          fullAddress: 'Av. Cristo Redentor 123',
          city: 'Santa Cruz',
          state: 'Santa Cruz',
          zipCode: '00002',
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 180)),
      isEmailVerified: true,
      isPhoneVerified: true,
    );
  }

  void updateUser(User user) {
    _currentUser = user;
    notifyListeners();
  }
}
