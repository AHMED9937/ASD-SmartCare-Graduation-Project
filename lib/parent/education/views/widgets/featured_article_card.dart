import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/education/models/article_model.dart';
import 'package:asdsmartcare/parent/education/views/article_details_screen.dart';
import 'package:flutter/material.dart';

/// A large, premium card for the spotlight article.
class FeaturedArticleCard extends StatelessWidget {
  final Data article;

  const FeaturedArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => _navigateToDetails(context),
      padding: EdgeInsets.zero,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white,
          AppColors.primary.withValues(alpha: 0.05),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Visual: Hero Image
          _buildHeroImage(),

          // Content
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: const Text(
                    'FEATURED',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const AppSpacer.sm(),
                Text(
                  article.title ?? 'No Title',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                    letterSpacing: -0.5,
                  ),
                ),
                const AppSpacer.sm(),
                Text(
                  article.info ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.onSurface.withValues(alpha: 0.7),
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const AppSpacer.lg(),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                      child: const Icon(Icons.person,
                          size: 14, color: AppColors.primary),
                    ),
                    const AppSpacer.sm(),
                    Text(
                      article.creator ?? 'Expert Contributor',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_rounded,
                        color: AppColors.primary),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppRadius.lg),
        topRight: Radius.circular(AppRadius.lg),
      ),
      child: AspectRatio(
        aspectRatio: 21 / 9,
        child: article.image != null && article.image!.isNotEmpty
            ? Image.network(
                article.image!,
                fit: BoxFit.cover,
                errorBuilder: (context, _, __) => _buildPlaceholder(),
              )
            : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.primary.withValues(alpha: 0.1),
      child: const Icon(
        Icons.auto_stories_rounded,
        color: AppColors.primary,
        size: 48,
      ),
    );
  }

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Showarticle(
          author: article.creator ?? 'Expert',
          content: article.info ?? '',
          date: article.createdAt ?? '',
          imageUrl: article.image ?? '',
          title: article.title ?? '',
        ),
      ),
    );
  }
}
