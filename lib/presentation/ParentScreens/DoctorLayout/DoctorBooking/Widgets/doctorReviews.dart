import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/Model/GetSessionReviewsList.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/cubit/sessionReviews/session_reviews_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/cubit/sessionReviews/session_reviews_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Example widget displaying session reviews in a ListView.builder
class ReviewListView extends StatelessWidget {
  final String ID;
  final bool showAllReviews;

  ReviewListView({Key? key, required this.ID, required this.showAllReviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = SessionReviewsListCubit();
        if (showAllReviews) {
          cubit.getDoctorSessionsReviewsList(ID);
        } else {
          cubit.getSessionReviewsList(ID);
        }
        return cubit;
      },
      child: BlocConsumer<SessionReviewsListCubit, GetSessionReviewsListStates>(
        listener: (_, __) {},
        builder: (context, state) {
          if (state is GetSessionReviewsListLoadingStates) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF133E87)),
            );
          }

          if (state is GetSessionReviewsListSuccsessStates) {
            final reviews = state.reviews;
            if (reviews!.isEmpty) {
              return const Center(
                child: Text('No reviews yet.', style: TextStyle(color: Colors.grey, fontSize: 12)),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              itemCount: reviews!.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCDFFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.grey.shade300,
                              child: const Icon(Icons.person, size: 14, color: Colors.white),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                review.parent?.userName ?? 'Anonymous',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  i < (review.ratings ?? 0) ? Icons.star : Icons.star_border,
                                  size: 14,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if ((review.title ?? '').isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            review.title!,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                       
                        
                      ],
                    ),
                  ),
                );
              },
            );
          }

          // fallback for error or other states
          return const Center(
            child: Text(
              'Error loading reviews',
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
