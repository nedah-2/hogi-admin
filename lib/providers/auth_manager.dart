import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hogi_milk_admin/utils/global_scafflold.dart';

class AuthManager extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isLoading = false;

  AuthManager() {
    _initAuth();
  }

  void _initAuth() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  User? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
    } catch (e) {
      // Handle sign-in errors
      debugPrint('Error signing in: $e');
      MySnackBar.showSnackBar('Invalid email or password');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _auth.signOut();
      await Future.delayed(const Duration(seconds: 2));
      _user = null;
    } catch (e) {
      // Handle sign-out errors
      debugPrint('Error signing out: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      //Handle Error
      debugPrint('Password Reset failed');
    }
  }
}
