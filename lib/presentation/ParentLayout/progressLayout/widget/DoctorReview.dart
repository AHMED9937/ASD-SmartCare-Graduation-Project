import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/controller/cubit/doctor_review_cubit.dart';
import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/controller/cubit/doctor_review_state.dart';
import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/model/GetAllSession.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';

/// A responsive dialog widget for submitting a doctor review
class DoctorReviewDialog extends StatelessWidget {
  final SessionData session;

  const DoctorReviewDialog({Key? key, required this.session}) : super(key: key);

  /// Static helper to show this dialog
  static Future<void> show(BuildContext context, SessionData session) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => DoctorReviewDialog(session: session),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return BlocProvider(
      create: (_) => DoctorReviewCubit(),
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: media.size.height * 0.8,
            maxWidth: media.size.width * 0.9,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocConsumer<DoctorReviewCubit, DoctorReviewStates>(
              listener: (context, state) {},
              builder: (context, state) {
                final cubit = DoctorReviewCubit.get(context);

                if (state is DoctorReviewStateLoaded) {
                  return _buildSuccessContent(context, 'Your doctor rating has been submitted.');
                }
                if (state is DoctorReviewStateError) {
                  return _buildErrorContent(context, () {
                    cubit.submitDoctorReview(session.doctorId?.id ?? '');
                  });
                }

                // default: rating form
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: media.viewInsets.bottom + 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Rate this Doctor',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (i) {
                          return SizedBox(
                            width: 40,
                            height: 40,
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
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Any comments (optional)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ConditionalBuilder(
                        condition: cubit.state is! DoctorReviewStateLoading,
                        builder: (_) => SizedBox(
                          height: 48,
                          child: AppButtons.containerTextButton(
                            TextUtils.textHeader('Submit Rating', headerTextColor: Colors.white),
                            () => cubit.submitDoctorReview(session.doctorId?.id ?? ''),
                          ),
                        ),
                        fallback: (_) => const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Success content widget
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

// Error content widget
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
