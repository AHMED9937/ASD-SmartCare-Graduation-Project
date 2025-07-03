import 'package:flutter/material.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';

/// Displays a full article with a header, summary, image, and detailed body,
/// with manual Text styling instead of TextUtils.
class Showarticle extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final String imageUrl;
  final String content;

  /// All fields are required to render the article detail page.
  const Showarticle({
    Key? key,
    required this.title,
    required this.author,
    required this.date,
    required this.imageUrl,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithText(context, "Educational Resources"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Subtitle under AppBar
            Text(
              "Education resources support learning",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Featured image
            if (imageUrl.isNotEmpty) ...[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: Image.network(
                  imageUrl,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Article Title
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8FADE1),
              ),
            ),
            const SizedBox(height: 16),

            // Author & Date row
            Row(
              children: [
                const Icon(Icons.person_outline, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  author,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const Divider(thickness: 1),
            const SizedBox(height: 24),

            // Full article content
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: theme.colorScheme.onBackground,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}