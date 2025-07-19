import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/DoctorBooking/Model/GetSessionReviewsList.dart';
import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/DoctorBooking/cubit/sessionReviews/session_reviews_state.dart';
import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionReviewsListCubit extends Cubit<GetSessionReviewsListStates> {
  SessionReviewsListCubit() : super(GetSessionReviewsListinitialStates());
  
  
  static SessionReviewsListCubit get(context) => BlocProvider.of(context); 
SessionReviews? DocSessionReviews; 
  void getDoctorSessionsReviewsList(String Did) {
    emit(GetSessionReviewsListLoadingStates());

    Diohelper.getData(
      url: ApiConstants.getDoctorSessionsReviewsList(Did), // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
     
       print(value.data);
       DocSessionReviews=SessionReviews.fromJson(value.data);

      
      emit(GetSessionReviewsListSuccsessStates(DocSessionReviews!.data));
    }).catchError((error) {
      print("Error fetching SessionReviews list: $error");
      emit(GetSessionReviewsListFailedStates());
    });
  }

 
  void getSessionReviewsList(String Sid) {
    emit(GetSessionReviewsListLoadingStates());

    Diohelper.getData(
      url: ApiConstants.GetSessionReviewsList(Sid), // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
     
       print(value.data);
       DocSessionReviews=SessionReviews.fromJson(value.data);

      
      emit(GetSessionReviewsListSuccsessStates(DocSessionReviews!.data));
    }).catchError((error) {
      print("Error fetching SessionReviews list: $error");
      emit(GetSessionReviewsListFailedStates());
    });
  }

}

