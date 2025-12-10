import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/education/controllers/articles_cubit.dart';
import 'package:asdsmartcare/parent/education/controllers/articles_state.dart';
import 'package:asdsmartcare/parent/education/models/article_model.dart';
import 'package:asdsmartcare/parent/education/views/articles_screen.dart';
import 'package:asdsmartcare/parent/education/views/widgets/article_card.dart';
import 'package:asdsmartcare/parent/education/views/widgets/featured_article_card.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'dart:io';

class MockArticlesCubit extends MockCubit<AvailableEducationArticaleState>
    implements AvailableEducationArticaleCubit {}

class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  HttpOverrides.global = TestHttpOverrides();
  late MockArticlesCubit mockCubit;

  setUp(() {
    mockCubit = MockArticlesCubit();
    registerFallbackValue(GetAvailableEducationArticaleStateInitial());
    when(() => mockCubit.getAvailableEducationArticale()).thenReturn(null);
    when(() => mockCubit.searchEducationArticale(any())).thenReturn(null);
  });

  Widget createWidget() {
    return MaterialApp(home: Articles(cubit: mockCubit));
  }

  group('Education Articles Screen Tests', () {
    testWidgets(
      'renders LoadingView when items list is empty and state is loading',
      (tester) async {
        when(
          () => mockCubit.state,
        ).thenReturn(GetAvailableEducationArticaleLoading());
        when(() => mockCubit.items).thenReturn([]);

        await tester.pumpWidget(createWidget());
        expect(find.byType(LoadingView), findsOneWidget);
      },
    );

    testWidgets('renders EmptyView when no articles are found', (tester) async {
      when(() => mockCubit.state).thenReturn(
        GetAvailableEducationArticaleSuccess(EducationArticaleModel(data: [])),
      );
      when(() => mockCubit.items).thenReturn([]);

      await tester.pumpWidget(createWidget());
      expect(find.byType(EmptyView), findsOneWidget);
      expect(
        find.text('No articles found matching your criteria.'),
        findsOneWidget,
      );
    });

    testWidgets('FeaturedArticleCard renders with correct content', (
      tester,
    ) async {
      final article = Data(
        title: 'Featured Post',
        info: 'Info 1',
        creator: 'Dev 1',
        image: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 400,
                height: 400,
                child: FeaturedArticleCard(article: article),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(FeaturedArticleCard), findsOneWidget);
      expect(find.text('Featured Post'), findsOneWidget);
      expect(find.text('FEATURED'), findsOneWidget);
    });

    testWidgets('ArticleCard renders with correct content', (tester) async {
      final article = Data(
        title: 'List Item 1',
        info: 'Info 2',
        creator: 'Dev 2',
        image: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 400,
                height: 150,
                child: ArticleCard(article: article),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ArticleCard), findsOneWidget);
      expect(find.text('List Item 1'), findsOneWidget);
      expect(find.text('Read'), findsOneWidget);
    });

    testWidgets('renders ErrorView when loading fails', (tester) async {
      when(
        () => mockCubit.state,
      ).thenReturn(GetAvailableEducationArticaleError('Server Error'));
      when(() => mockCubit.items).thenReturn([]);

      await tester.pumpWidget(createWidget());
      expect(find.byType(ErrorView), findsOneWidget);
      expect(find.text('Server Error'), findsOneWidget);
    });
  });
}
