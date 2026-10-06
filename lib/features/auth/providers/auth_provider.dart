/// auth_provider.dart - Auth state + API calls
/// Feature: Auth

import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  UserModel? _user;
  String _selectedRole = 'student';

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserModel? get user => _user;
  String get selectedRole => _selectedRole;

  void setRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      // TODO(API): POST /api/v1/auth/login
      // Body: { "email": email, "password": password }
      await Future.delayed(const Duration(seconds: 2));
      _user = UserModel(
          id: '1', name: 'Demo User', email: email, role: _selectedRole);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'Login failed. Please try again.';
      _setLoading(false);
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      // TODO(API): POST /api/v1/auth/register
      await Future.delayed(const Duration(seconds: 2));
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'Registration failed.';
      _setLoading(false);
      return false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      // TODO(API): POST /api/v1/auth/verify-otp
      await Future.delayed(const Duration(seconds: 2));
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'Invalid OTP.';
      _setLoading(false);
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      // TODO(API): POST /api/v1/auth/forgot-password
      // Body: { "email": email }
      await Future.delayed(const Duration(seconds: 2));
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to send code.';
      _setLoading(false);
      return false;
    }
  }

  Future<bool> resetPassword(String newPassword) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      // TODO(API): POST /api/v1/auth/reset-password
      // Body: { "password": newPassword }
      await Future.delayed(const Duration(seconds: 2));
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to reset password.';
      _setLoading(false);
      return false;
    }
  }
}
