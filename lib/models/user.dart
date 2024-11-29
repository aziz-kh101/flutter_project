
class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String address;
  final String phone;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.address = '',
    this.phone = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}