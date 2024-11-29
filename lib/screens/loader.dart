
import 'package:flutter/material.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/services/auth_service.dart';
import 'package:provider/provider.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  void getUserdata(context) async {
    final user = await authService.getUser();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    if(user != null) {
      Navigator.pushReplacementNamed(context, '/tabs');
      userProvider.setUserAndLoading(user, false);
    }
    else {
      Navigator.pushReplacementNamed(context, '/auth/sign-in');
      userProvider.setLoading(false);
    }
  }


  @override
  Widget build(BuildContext context) {
    getUserdata(context);

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
