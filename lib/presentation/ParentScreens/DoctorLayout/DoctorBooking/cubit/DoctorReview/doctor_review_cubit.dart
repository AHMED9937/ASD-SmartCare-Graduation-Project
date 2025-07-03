// import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
// import 'package:asdsmartcare/appShared/remote/diohelper.dart';
// import 'package:asdsmartcare/networking/api_constants.dart';
// import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/cubit/DoctorReview/doctor_review_state.dart';
// import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';
// import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class DoctorReviewsListCubit extends Cubit<GetDoctorReviewsListStates> {
//   DoctorReviewsListCubit() : super(GetDoctorReviewsListinitialStates());
  
  
//   static DoctorReviewsListCubit get(context) => BlocProvider.of(context); 
// DoctorReviews? DocDoctorReviews; 
//   void getDoctorReviewsList(String id) {
//     emit(GetDoctorReviewsListLoadingStates());

//     Diohelper.getData(
//       url: ApiConstants.GetDoctorReviewsList(id), // Ensure this matches your API endpoint key
//       token: CacheHelper.getData(key: "token"),
//     ).then((value) {
     
//        print(value.data);

      
//       emit(GetDoctorReviewsListSuccsessStates());
//     }).catchError((error) {
//       print("Error fetching DoctorReviews list: $error");
//       emit(GetDoctorReviewsListFailedStates());
//     });
//   }
// }

