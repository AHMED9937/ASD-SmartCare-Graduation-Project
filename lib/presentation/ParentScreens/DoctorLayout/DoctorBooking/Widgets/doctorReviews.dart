import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/Model/GetSessionReviewsList.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/cubit/sessionReviews/session_reviews_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/cubit/sessionReviews/session_reviews_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Model representing a customer review
class Review {
  final String name;
  final int rating;
  final String comment;
  final String timeAgo;
  final String? avatarUrl;

  Review({
    required this.name,
    required this.rating,
    required this.comment,
    required this.timeAgo,
    this.avatarUrl,
  });
}

/// Example widget displaying session reviews in a ListView.builder
class ReviewListView extends StatelessWidget {
  final String DoctorId;
  ReviewListView({Key? key, required this.DoctorId}) : super(key: key);

  // Holds fetched session reviews
  List<SesstionReview>? reviews = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionReviewsListCubit()..getSessionReviewsList(DoctorId),
      child: BlocConsumer<SessionReviewsListCubit, GetSessionReviewsListStates>(
        listener: (context, state) {
          // you can handle side-effects here
        },
        builder: (context, state) {
          if (state is GetSessionReviewsListLoadingStates) {
            return Center(
              child: CircularProgressIndicator(color: Color(0xFF133E87)),
            );
          }

          if (state is GetSessionReviewsListSuccsessStates) {
            // assign fetched reviews
            reviews = state.reviews;

            // empty-case
            if (reviews == null || reviews!.isEmpty) {
              return const Center(
                child: Text('No reviews yet.', style: TextStyle(color: Colors.grey)),
              );
            }

            // build list
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: reviews!.length,
              itemBuilder: (context, index) {
                final review = reviews![index];
                return Padding(
                  padding: const EdgeInsets.symmetric( vertical: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCDFFF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // if (review.parent?.avatarUrl != null)
                            //   CircleAvatar(
                            //     radius: 16,
                            //     backgroundImage: NetworkImage(review.parent!.avatarUrl!),
                            //   )
                            // else
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.grey.shade300,
                                child: const Icon(Icons.person, size: 16, color: Colors.white),
                              ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                review.parent?.userName ?? 'Anonymous',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  i < (review.ratings ?? 0) ? Icons.star : Icons.star_border,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          review.title ?? '',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          // fallback for error or other states
          return Center(
            child: Text("Error",
            ),
          );
        },
      ),
    );
  }
}
