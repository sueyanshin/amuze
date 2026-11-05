import 'package:amuze_app/screens/providers/posts_provider.dart';
import 'package:amuze_app/widgets/post_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
            return SafeArea(child: ShimmerContainer());
            // return const Center(child: CircularProgressIndicator());
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
              // itemCount:
              //     provider.posts.length +
              //     (provider.hasMore || provider.errorMessage != null ? 1 : 0),

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

class ShimmerContainer extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
      highlightColor: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade100,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 12, width: 200, color: Colors.white),
                        const SizedBox(height: 6),
                        Container(height: 12, width: 140, color: Colors.white),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
