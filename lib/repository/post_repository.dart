import 'package:amuze_app/models/post.dart';
import 'package:amuze_app/service/api_service.dart';
import 'package:amuze_app/service/token_storage.dart';

class PostRepository {
  final ApiService _apiService;
  final TokenStorage _tokenStorage;

  new(this._apiService, this._tokenStorage);

  Future<List<Post>> getPosts({
    required int page,
    required int pageSize,
  }) async {
    final token = await _tokenStorage.getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Please log in first');
    }
    return _apiService.getPosts(token: token, page: page, pageSize: pageSize);
  }
}
