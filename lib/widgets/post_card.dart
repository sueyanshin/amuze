import 'package:amuze_app/models/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = post.createdByUser;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 0,
      color: theme.colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User information
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _buildProfileImage(user?.profile, theme),
                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? 'common.unknown_user'.tr(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        post.createdAt?.toString() ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                OutlinedButton(
                  onPressed: post.isFollow == true ? null : () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(post.isFollow == true ? 'Followed' : 'Follow'),
                ),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),

          // Post text
          if (post.name != null && post.name!.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Text(
                post.name!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),

          // Post image
          if (post.thumbnail != null && post.thumbnail!.isNotEmpty)
            CachedNetworkImage(
              imageUrl: post.thumbnail!,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => const SizedBox(
                height: 220,
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => SizedBox(
                height: 120,
                child: Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: 40,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),

          // Likes, comments and views
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                _PostStat(
                  icon: Icons.thumb_up_alt_outlined,
                  count: post.likes ?? 0,
                  onTap: () {},
                ),
                _PostStat(
                  icon: Icons.comment_outlined,
                  count: post.comments ?? 0,
                  onTap: () {},
                ),
                const Spacer(),
                _PostStat(
                  icon: Icons.remove_red_eye_outlined,
                  count: post.views ?? 0,
                  onTap: () {},
                ),
              ],
            ),
          ),

          Divider(height: 1, color: theme.colorScheme.outlineVariant),
        ],
      ),
    );
  }

  Widget _buildProfileImage(String? imageUrl, ThemeData theme) {
    final hasImage = imageUrl != null && imageUrl.trim().isNotEmpty;

    return ClipOval(
      child: SizedBox(
        width: 44,
        height: 44,
        child: hasImage
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => _avatarPlaceholder(theme),
                errorWidget: (context, url, error) => _avatarPlaceholder(theme),
              )
            : _avatarPlaceholder(theme),
      ),
    );
  }

  Widget _avatarPlaceholder(ThemeData theme) {
    return ColoredBox(
      color: theme.colorScheme.primaryContainer,
      child: Icon(Icons.person, color: theme.colorScheme.onPrimaryContainer),
    );
  }
}

class _PostStat extends StatelessWidget {
  const _PostStat({
    required this.icon,
    required this.count,
    required this.onTap,
  });

  final IconData icon;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: theme.colorScheme.onSurfaceVariant,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 19),
          const SizedBox(width: 5),
          Text(
            count.toString(),
            style: theme.textTheme.labelMedium!.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
