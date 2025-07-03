import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asdsmartcare/presentation/ParentScreens/progressLayout/controller/sessionReview/session_review_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/progressLayout/controller/sessionReview/session_review_state.dart';
import 'package:asdsmartcare/presentation/ParentScreens/progressLayout/model/GetAllSession.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';

/// 1) Helper that grabs the existing cubit and injects it into the dialog
void showRatingDialog(BuildContext outerContext, SessionData session) {
  final cubit = SessionReviewCubit.get(outerContext);
  showDialog(
    context: outerContext,
    barrierDismissible: true,
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: _RatingDialog(session: session),
    ),
  );
}

/// 2) The page that shows comments and a “Rate This Session” button
class SessionDeatile extends StatelessWidget {
  final SessionData session;

  const SessionDeatile({Key? key, required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SessionReviewCubit(),
      child: BlocConsumer<SessionReviewCubit, SessionReviewState>(
        listener: (context, state) {
          // Could handle page‐level submission results here if desired
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarWithText(
              context,
              "Session Number ${session.sessionNumber}",
            ),
            body: SesstionReview(session: session),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.fromLTRB(25, 12, 25, 20),
              child: AppButtons.containerTextButton(
                TextUtils.textHeader(
                  "Rate This Session!",
                  headerTextColor: Colors.white,
                ),
                () => showRatingDialog(context, session),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SesstionReview extends StatelessWidget {
  const SesstionReview({
    super.key,
    required this.session,
  });

  final SessionData session;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: session.comments?.length ?? 0,
      itemBuilder: (context, index) {
        final comment = session.comments![index];
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 25, vertical: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFE3EEFF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          session.sessionDate ?? "",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        comment,
                        style: const TextStyle(
                          color: Color(0xFF133E87),
                          fontSize: 14,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// 3) The rating dialog, fully rebuilt off cubit state
class _RatingDialog extends StatelessWidget {
  final SessionData session;
  const _RatingDialog({Key? key, required this.session}) : super(key: key);

  Widget _buildStar(SessionReviewCubit cubit, int i) => IconButton(
        iconSize: 32,
        icon: Icon(
          i < cubit.rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
        ),
        onPressed: () => cubit.updateRating(i + 1),
      );

  @override
  Widget build(BuildContext context) {
    final cubit = SessionReviewCubit.get(context);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: BlocConsumer<SessionReviewCubit, SessionReviewState>(
        listener: (context, state) {
          if (state is SessionReviewStateLoaded) {
            Navigator.of(context).pop(); // close on success
          } else if (state is SessionReviewStateError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("error")));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Rate this session",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) => _buildStar(cubit, i)),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: cubit.controller,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      hintText: "Why you recommend this doctor (optional)",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ← Now correctly uses `state is! SessionReviewStateLoading`
              // inside your BlocBuilder/BlocConsumer in _RatingDialog
ConditionalBuilder(
  condition: state is! SessionReviewStateLoading,
  builder: (_) => AppButtons.containerTextButton(
    TextUtils.textHeader(
      "Rate Session",
      headerTextColor: Colors.white,
    ),
    () {
      // 1) dismiss the keyboard
      FocusScope.of(context).unfocus();

      // 2) emit loading & start your API call
      cubit.submitReview(session.sId ?? "");
    },
  ),
  fallback: (_) => const SizedBox(
    height: 44,
    child: Center(child: CircularProgressIndicator()),
  ),
),
 ],
            ),
          );
        },
      ),
    );
  }
}
