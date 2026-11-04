import 'package:amuze_app/service/api_service.dart';
import 'package:amuze_app/service/token_storage.dart';

class AuthRepository {
  final ApiService _apiService;
  final TokenStorage _tokenStorage;

  new(this._apiService, this._tokenStorage);

  Future<String> login({
    required String emailOrPhone,
    required String password,
  }) async {
    final token = await _apiService.login(
      emailOrPhone: emailOrPhone,
      password: password,
    );
    _tokenStorage.saveToken(token);

    return token;
  }

  Future<String?> getSavedToken() async {
    return _tokenStorage.getToken();
  }

  Future<void> logout() async {
    await _tokenStorage.removeToken();
  }
}
