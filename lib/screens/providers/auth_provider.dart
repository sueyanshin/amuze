import 'package:amuze_app/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  new(this._authRepository);

  bool _isLoading = false;
  String? _token;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get token => _token;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _token != null;

  Future<void> restoreSession() async {
    _token = await _authRepository.getSavedToken();
    notifyListeners();
  }

  Future<bool> login({
    required String emailOrPhone,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _token = await _authRepository.login(
        emailOrPhone: emailOrPhone,
        password: password,
      );
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _isLoading = false;
    _errorMessage = null;
    restoreSession();
    notifyListeners();
  }
}
