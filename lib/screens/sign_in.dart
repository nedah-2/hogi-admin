import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    void showSnack(String message, bool isError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: isError ? Colors.deepOrange : Colors.green,
        content: Text(message),
        duration: const Duration(milliseconds: 1200),
      ));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/images/aya_logo.png',
              //   width: 512,
              //   height: 100,
              // ),
              // const SizedBox(
              //   height: 16,
              // ),
              TextFormField(
                enabled: _isLoading ? false : true,
                controller: _userController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    prefixIcon: Icon(Icons.account_circle),
                    labelText: 'Username',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                enabled: _isLoading ? false : true,
                controller: _passwordController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    labelText: 'Password',
                    border: const OutlineInputBorder()),
                obscureText: _isPasswordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 8,
                      shadowColor: Colors.red[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      _userController.clear();
                      _passwordController.clear();
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ))
                      : const Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
