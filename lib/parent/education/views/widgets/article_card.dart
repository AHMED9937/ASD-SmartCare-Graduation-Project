import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/education/models/article_model.dart';
import 'package:asdsmartcare/parent/education/views/article_details_screen.dart';
import 'package:flutter/material.dart';

/// A standard card for educational articles.
class ArticleCard extends StatelessWidget {
  final Data article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => _navigateToDetails(context),
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          // Visual: Clipped Image
          Expanded(
            flex: 3,
            child: _buildImage(),
          ),

          // Content
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? 'No Title',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const AppSpacer.xs(),
                  Text(
                    article.info ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.onSurface.withValues(alpha: 0.6),
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const AppSpacer.sm(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMetaData(),
                      AppButton(
                        label: 'Read',
                        size: AppButtonSize.small,
                        style: AppButtonStyle.secondary,
                        expanded: false,
                        onPressed: () => _navigateToDetails(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppRadius.lg),
        bottomLeft: Radius.circular(AppRadius.lg),
      ),
      child: AspectRatio(
        aspectRatio: 1 / 1,
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
        Icons.article_rounded,
        color: AppColors.primary,
        size: 24,
      ),
    );
  }

  Widget _buildMetaData() {
    final date = article.createdAt?.split('T').first ?? '';
    return Text(
      date,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.primary.withValues(alpha: 0.6),
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
