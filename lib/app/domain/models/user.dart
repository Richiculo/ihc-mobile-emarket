class User {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final List<Address> addresses;
  final String? profileImage;
  final DateTime createdAt;
  final bool isEmailVerified;
  final bool isPhoneVerified;

  const User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.addresses,
    this.profileImage,
    required this.createdAt,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
  });

  Address? get defaultAddress {
    if (addresses.isEmpty) return null;

    try {
      return addresses.firstWhere((address) => address.isDefault);
    } catch (e) {
      // Si no hay dirección marcada como default, retorna la primera
      return addresses.first;
    }
  }

  String get firstName => fullName.split(' ').first;
  String get initials {
    final names = fullName.split(' ');
    return names.length >= 2
        ? '${names[0][0]}${names[1][0]}'.toUpperCase()
        : fullName.isNotEmpty
        ? fullName[0].toUpperCase()
        : 'U';
  }
}

class Address {
  final String id;
  final String label;
  final String fullAddress;
  final String city;
  final String state;
  final String zipCode;
  final bool isDefault;
  final double? latitude;
  final double? longitude;

  const Address({
    required this.id,
    required this.label,
    required this.fullAddress,
    required this.city,
    required this.state,
    required this.zipCode,
    this.isDefault = false,
    this.latitude,
    this.longitude,
  });

  String get formattedAddress => '$fullAddress, $city, $state';
}
