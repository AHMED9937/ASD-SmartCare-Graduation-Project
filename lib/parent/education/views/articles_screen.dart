import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/education/controllers/articles_cubit.dart';
import 'package:asdsmartcare/parent/education/controllers/articles_state.dart';
import 'package:asdsmartcare/parent/education/views/widgets/articles_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Redesigned Education Articles screen.
///
/// Follows SOLID principles by delegating state management to Cubit
/// and UI logic to specialized sub-widgets.
class Articles extends StatelessWidget {
  final AvailableEducationArticaleCubit? cubit;
  const Articles({super.key, this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          cubit ??
          (AvailableEducationArticaleCubit()..getAvailableEducationArticale()),
      child: Scaffold(
        appBar: const AppHeader(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageHeader(
              title: 'Education',
              subtitle: 'Learn more about ASD and care strategies',
            ),
            Expanded(
              child:
                  BlocBuilder<
                    AvailableEducationArticaleCubit,
                    AvailableEducationArticaleState
                  >(
                    builder: (context, state) {
                      final cubit = AvailableEducationArticaleCubit.get(
                        context,
                      );

                      if (state is GetAvailableEducationArticaleLoading &&
                          cubit.items.isEmpty) {
                        return const LoadingView();
                      }

                      if (state is GetAvailableEducationArticaleError &&
                          cubit.items.isEmpty) {
                        return ErrorView(
                          message: state.error,
                          onRetry: () => cubit.getAvailableEducationArticale(),
                        );
                      }

                      if (cubit.items.isEmpty &&
                          state is GetAvailableEducationArticaleSuccess) {
                        return EmptyView(
                          message: 'No articles found matching your criteria.',
                          icon: Icons.article_outlined,
                          actionText: 'Clear Search',
                          onAction: () {
                            cubit.getAvailableEducationArticale();
                          },
                        );
                      }

                      return ArticlesBody(cubit: cubit, state: state);
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
