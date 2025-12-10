import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/education/controllers/articles_cubit.dart';
import 'package:asdsmartcare/parent/education/controllers/articles_state.dart';
import 'package:asdsmartcare/parent/education/views/widgets/article_card.dart';
import 'package:asdsmartcare/parent/education/views/widgets/featured_article_card.dart';
import 'package:flutter/material.dart';

/// The core content of the Education screen.
///
/// Handles search, featured content, and the scrollable list of articles.
class ArticlesBody extends StatelessWidget {
  final AvailableEducationArticaleCubit cubit;
  final AvailableEducationArticaleState state;

  const ArticlesBody({super.key, required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    final items = cubit.items;
    final featuredArticle = items.isNotEmpty ? items.first : null;
    final otherArticles = items.length > 1 ? items.sublist(1) : [];

    return ResponsivePadding(
      child: RefreshIndicator(
        onRefresh: () async => cubit.getAvailableEducationArticale(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // 1. Search Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: AppSearchField(
                  hint: 'Search for resources...',
                  onChanged: (value) {
                    if (value.length > 2 || value.isEmpty) {
                      cubit.searchEducationArticale(value);
                    }
                  },
                ),
              ),
            ),

            // 2. Featured Article (Hero)
            if (featuredArticle != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeader(
                        title: 'Spotlight',
                        padding: EdgeInsets.zero,
                      ),
                      const AppSpacer.md(),
                      FeaturedArticleCard(article: featuredArticle),
                      const AppSpacer.xl(),
                    ],
                  ),
                ),
              ),

            // 3. All Articles List
            if (otherArticles.isNotEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: SectionHeader(
                    title: 'Top Resources',
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),

            SliverPadding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: ArticleCard(article: otherArticles[index]),
                  );
                }, childCount: otherArticles.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
