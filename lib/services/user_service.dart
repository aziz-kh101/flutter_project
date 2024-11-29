import 'package:project/helpers/apis.dart';
import 'package:project/helpers/http_client.dart';
import 'package:project/models/user.dart';

class _UserService {

  Future<String> updateUserProfile(User user) async {
    final result = await client.put(Uri.parse(Apis.userProfile), body: {
      'email': user.email,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'phone': user.phone,
      'address': user.address,
    });

    if (result.statusCode == 200) {
      return 'Profile updated successfully';
    }
    else {
      throw Exception('Failed to update profile');
    }
  }
}

final userService = _UserService();