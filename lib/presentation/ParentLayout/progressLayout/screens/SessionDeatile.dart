import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/controller/cubit/doctor_review_cubit.dart';
import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/controller/cubit/doctor_review_state.dart';
import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/widget/DoctorReview.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/controller/sessionReview/session_review_cubit.dart';
import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/controller/sessionReview/session_review_state.dart';
import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/model/GetAllSession.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';

/// Show rating dialogs
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
class SessionDetail extends StatelessWidget {
  final SessionData session;
  const SessionDetail({Key? key, required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SessionReviewCubit(),
      child: BlocConsumer<SessionReviewCubit, SessionReviewState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarWithText(
              context,
              "Session Number ${session.sessionNumber}",
            ),
            body: SesstionReview(session: session),
            bottomNavigationBar: Row(
              children: [
                Expanded(
                  child: AppButtons.containerTextButton(
                    TextUtils.textHeader(
                      "Rate Session",
                      headerTextColor: Colors.white,
                    ),
                    () => showRatingDialog(context, session),
                  ),
                ),
             Expanded(
  child: AppButtons.containerTextButton(
    TextUtils.textHeader("Rate Doctor", headerTextColor: Colors.white),
    () => DoctorReviewDialog.show(context, session),
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

class SesstionReview extends StatelessWidget {
  final SessionData session;
  const SesstionReview({Key? key, required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: session.comments?.length ?? 0,
      itemBuilder: (context, index) {
        final comment = session.comments![index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFE3EEFF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(radius: 24, backgroundColor: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "${session.sessionDate ?? ''}",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        comment,
                        style: const TextStyle(color: Color(0xFF133E87), fontSize: 14),
                        softWrap: true,
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

/// Session‐rating dialog
class _RatingDialog extends StatelessWidget {
  final SessionData session;
  const _RatingDialog({Key? key, required this.session}) : super(key: key);

  Widget _buildStar(SessionReviewCubit cubit, int i) => SizedBox(
        width: 36,
        child: IconButton(
          iconSize: 28,
          padding: EdgeInsets.zero,
          icon: Icon(i < cubit.rating ? Icons.star : Icons.star_border, color: Colors.amber),
          onPressed: () => cubit.updateRating(i + 1),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final cubit = SessionReviewCubit.get(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: BlocConsumer<SessionReviewCubit, SessionReviewState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SessionReviewStateLoaded) {
            return _buildSuccessContent(context, 'Your rating has been submitted successfully.');
          }
          if (state is SessionReviewStateError) {
            return _buildErrorContent(context, () {
              cubit.submitSessionReview(session.sId ?? '');
            });
          }
          return _buildFormContent(
            cubit,
            () => cubit.submitSessionReview(session.sId ?? ''),
            title: 'Rate this session',
            buttonText: 'Rate Session',
          );
        },
      ),
    );
  }
}

// Shared widgets

Widget _buildSuccessContent(BuildContext context, String message) {
  return Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle, color: Colors.green, size: 64),
        const SizedBox(height: 16),
        const Text('Thank you!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(message, textAlign: TextAlign.center),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: AppButtons.containerTextButton(
            TextUtils.textHeader('Close', headerTextColor: Colors.white),
            () => Navigator.of(context).pop(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildErrorContent(BuildContext context, VoidCallback onRetry) {
  return Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error, color: Colors.red, size: 64),
        const SizedBox(height: 16),
        const Text('Submission Failed', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Please try again.', textAlign: TextAlign.center),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: AppButtons.containerTextButton(
            TextUtils.textHeader('Retry', headerTextColor: Colors.white),
            onRetry,
          ),
        ),
      ],
    ),
  );
}



Widget _buildFormContent(
  SessionReviewCubit cubit,
  VoidCallback onSubmit, {
  String title = 'Rate this session',
  String buttonText = 'Rate',
}) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (i) {
            return SizedBox(
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
          }),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: cubit.controller,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'Any comments (optional)', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 24),
        ConditionalBuilder(
          condition: cubit.state is! SessionReviewStateLoading,
          builder: (_) => SizedBox(
            height: 48,
            child: AppButtons.containerTextButton(
              TextUtils.textHeader(buttonText, headerTextColor: Colors.white),
              onSubmit,
            ),
          ),
          fallback: (_) => const Center(child: CircularProgressIndicator()),
        ),
      ],
    ),
  );
}

