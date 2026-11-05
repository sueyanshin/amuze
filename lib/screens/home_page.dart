import 'package:amuze_app/screens/providers/posts_provider.dart';
import 'package:amuze_app/widgets/post_card.dart';
import 'package:amuze_app/widgets/post_shimmer_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<PostProvider>().fetchInitialPosts();
      }
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    final threshold = position.maxScrollExtent - 300;

    if (position.pixels >= threshold && !position.outOfRange) {
      final provider = context.read<PostProvider>();

      print("isLoading: ${provider.isLoading}");
      print("isLoadingMore: ${provider.isLoadingMore}");
      print("hasMore: ${provider.hasMore}");
      print("errorMessage: ${provider.errorMessage}");

      if (!provider.isLoading && // false
          !provider.isLoadingMore && // false
          provider.hasMore && // true
          provider.errorMessage == null) {
        print("Calling fetchNextPage safely from scroll");
        provider.fetchNextPage();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          // Loading
          if (provider.isLoading && provider.posts.isEmpty) {
            return SafeArea(child: PostShimmerContainer());
          }
          // Retry
          if (provider.errorMessage != null && provider.posts.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: .min,
                children: [
                  Text(provider.errorMessage!),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      provider.fetchInitialPosts();
                    },
                    child: Text('common.retry'.tr()),
                  ),
                ],
              ),
            );
          }

          // No Posts found
          if (provider.posts.isEmpty) {
            return Center(child: Text('common.no_posts_found'.tr()));
          }

          return RefreshIndicator(
            onRefresh: () {
              return provider.fetchInitialPosts();
            },
            child: ListView.builder(
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount:
                  provider.posts.length +
                  (provider.isLoadingMore || provider.errorMessage != null
                      ? 1
                      : 0),

              itemBuilder: (context, index) {
                // reached page end
                if (index == provider.posts.length) {
                  // Retry loading more
                  if (provider.errorMessage != null) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(provider.errorMessage!),
                          TextButton(
                            onPressed: () {
                              context.read<PostProvider>().retryNextPage();
                            },
                            child: Text('common.retry_loading_more'.tr()),
                          ),
                        ],
                      ),
                    );
                  }

                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final post = provider.posts[index];
                return PostCard(post: post);
              },
            ),
          );
        },
      ),
    );
  }
}
