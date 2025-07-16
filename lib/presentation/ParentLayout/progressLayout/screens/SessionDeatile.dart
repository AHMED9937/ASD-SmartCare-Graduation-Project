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

  final  session;

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
                          "${session.sessionDate ??""}" ,
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

  Widget _buildStar(SessionReviewCubit cubit, int i) => SizedBox(
        width: 36,
        child: IconButton(
          iconSize: 28,
          padding: EdgeInsets.zero,
          icon: Icon(
            i < cubit.rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () => cubit.updateRating(i + 1),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final cubit = SessionReviewCubit.get(context);

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: BlocConsumer<SessionReviewCubit, SessionReviewState>(
        listener: (context, state) {
          // no-op: UI handled in builder
        },
        builder: (context, state) {
          // Success state
          if (state is SessionReviewStateLoaded) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 64),
                  const SizedBox(height: 16),
                  const Text(
                    "Thank you!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Your rating has been submitted successfully.",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 57,
                    child: AppButtons.containerTextButton(
                      TextUtils.textHeader(
                        "Close",
                        headerTextColor: Colors.white,
                        fontSize: 16,
                      ),
                      () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            );
          }

          // Error state
          if (state is SessionReviewStateError) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  const Text(
                    "Submission Failed",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                   "An unexpected error occurred.",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 57,
                    child: AppButtons.containerTextButton(
                      TextUtils.textHeader(
                        "Retry",
                        headerTextColor: Colors.white,
                        fontSize: 16,
                      ),
                      () {
                        FocusScope.of(context).unfocus();
                        cubit.submitSessionReview(session.sId ?? "");
                        cubit.submitDoctorReview(session.doctorId!.id ?? "");
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          // Default (loading or initial) state
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Rate this session",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) => _buildStar(cubit, i)),
                ),
                const SizedBox(height: 20),
                Container(
                  constraints: const BoxConstraints(minHeight: 80, maxHeight: 120),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                const SizedBox(height: 24),
                ConditionalBuilder(
                  condition: state is! SessionReviewStateLoading,
                  builder: (_) => SizedBox(
                    height: 57,
                    child: AppButtons.containerTextButton(
                      TextUtils.textHeader(
                        "Rate Session",
                        headerTextColor: Colors.white,
                        fontSize: 16,
                      ),
                      () {
                        FocusScope.of(context).unfocus();
                        cubit.submitSessionReview(session.sId ?? "");
                        cubit.submitDoctorReview(session.doctorId!.id ?? "");
                      },
                    ),
                  ),
                  fallback: (_) => const SizedBox(
                    height: 48,
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
