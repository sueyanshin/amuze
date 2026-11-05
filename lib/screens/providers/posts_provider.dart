import 'package:amuze_app/models/post.dart';
import 'package:amuze_app/repository/post_repository.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  final PostRepository _postRepository;
  new(this._postRepository);

  static final int _pageSize = 10;
  int _currentPage = 1;

  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  String? _errorMessage;
  final List<Post> _posts = [];

  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;

  String? get errorMessage => _errorMessage;
  List<Post> get posts => List.unmodifiable(_posts);

  Future<void> fetchInitialPosts() async {
    if (_isLoading) return;

    _isLoading = true;
    _isLoadingMore = false;
    _errorMessage = null;
    _currentPage = 1;
    _hasMore = true;
    _posts.clear();
    notifyListeners();

    try {
      final newPosts = await _postRepository.getPosts(
        page: 1,
        pageSize: _pageSize,
      );
      _posts.addAll(newPosts);
      _currentPage = 1;
      // _hasMore = newPosts.length == _pageSize;
      _hasMore = true;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchNextPage() async {
    if (_isLoading || _isLoadingMore || !hasMore || _errorMessage != null) {
      return;
    }

    _isLoadingMore = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final nextPage = _currentPage + 1;
      final newPosts = await _postRepository.getPosts(
        page: nextPage,
        pageSize: _pageSize,
      );
      _posts.addAll(newPosts);
      print("Calling after addAll .....");
      _currentPage = nextPage;
      // _hasMore = newPosts.length == _pageSize;
      _hasMore = true;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> retryNextPage() async {
    _errorMessage = null;

    await fetchNextPage();
  }

  void clearPosts() {
    _posts.clear();
    _currentPage = 1;
    _hasMore = true;
    _isLoading = false;
    _isLoadingMore = false;
    _errorMessage = null;
    notifyListeners();
  }
}
