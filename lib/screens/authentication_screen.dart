import 'package:flutter/material.dart';
import 'package:hogi_milk_admin/providers/auth_manager.dart';
import 'package:hogi_milk_admin/screens/home_screen.dart';
import 'package:hogi_milk_admin/screens/sign_in.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthManager>(
      builder: (context, authProvider, _) {
        if (authProvider.user == null && authProvider.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (authProvider.user == null && !authProvider.isLoading) {
          return const SignInScreen();
        } else {
          return const HomeScreen();
        }
      },
    );
  }
}
