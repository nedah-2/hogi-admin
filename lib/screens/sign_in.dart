import 'package:flutter/material.dart';
import 'package:hogi_milk_admin/providers/auth_manager.dart';
import 'package:hogi_milk_admin/screens/reset_password.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    final authManager = Provider.of<AuthManager>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 120, 24, 24),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/orders.png'),
              const SizedBox(height: 24),
              _buildSignInForm(context, authManager),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm(BuildContext context, AuthManager authManager) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            controller: userController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(16),
              prefixIcon: Icon(Icons.account_circle),
              labelText: 'Email Address',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            controller: passwordController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                icon: Icon(
                  isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                ),
              ),
              labelText: 'Password',
              border: const OutlineInputBorder(),
            ),
            obscureText: isPasswordVisible,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildForgotPasswordLink(context),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 8,
                  shadowColor: Colors.green[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  // Perform sign-in
                  await authManager.signInWithEmailAndPassword(
                    userController.text,
                    passwordController.text,
                  );
                }
              },
              child: const Text('LOGIN'),
            ),
          ),
        ],
      ),
    );
  }

  _buildForgotPasswordLink(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () async {
          // Implement forgot password functionality
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ResetPasswordScreen(),
              ));
        },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}
