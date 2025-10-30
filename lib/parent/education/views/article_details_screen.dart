import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';

/// Redesigned Article Details screen with premium interactions.
class Showarticle extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final String imageUrl;
  final String content;

  const Showarticle({
    super.key,
    required this.title,
    required this.author,
    required this.date,
    required this.imageUrl,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: MeshGradientBackground(
        child: CustomScrollView(
          slivers: [
            // 1. Creative Hero Image Header
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: AppColors.primary,
              leading: const _CircularBackButton(),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (imageUrl.isNotEmpty)
                      Image.network(imageUrl, fit: BoxFit.cover)
                    else
                      Container(
                          color: AppColors.primary.withValues(alpha: 0.2)),

                    // Gradient Overlay for readability
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black26,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Article Content
            SliverToBoxAdapter(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppRadius.xl),
                    topRight: Radius.circular(AppRadius.xl),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.xl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Metadata Row
                      _buildTags(),
                      const AppSpacer.lg(),

                      // Title
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDark,
                          letterSpacing: -0.8,
                          height: 1.2,
                        ),
                      ),
                      const AppSpacer.lg(),

                      // Author Card
                      _buildAuthorInfo(),
                      const AppSpacer.xl(),

                      const AppDivider(),
                      const AppSpacer.xl(),

                      // Body Content
                      Text(
                        content,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.7,
                          color: AppColors.onSurface.withValues(alpha: 0.8),
                          letterSpacing: 0.2,
                        ),
                      ),
                      const AppSpacer.xxl(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ), // CustomScrollView
      ), // MeshGradientBackground
    ); // Scaffold
  }

  Widget _buildTags() {
    return const Row(
      children: [
        _Tag(label: 'Education', color: AppColors.primary),
        AppSpacer.sm(),
        _Tag(label: 'Expert Verified', color: Colors.green),
      ],
    );
  }

  Widget _buildAuthorInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: const Icon(Icons.person, color: AppColors.primary),
        ),
        const AppSpacer.md(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              author,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDark,
              ),
            ),
            Text(
              date.split('T').first,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
        const Spacer(),
        AppIconButton(
          icon: Icons.share_rounded,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _CircularBackButton extends StatelessWidget {
  const _CircularBackButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 18, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  const _Tag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
