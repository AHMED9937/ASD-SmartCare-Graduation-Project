
// Cubit
import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/Doctor/Clinic/cubit/clinic_state.dart';
import 'package:asdsmartcare/presentation/Doctor/Clinic/model/GetDoctorAvailability.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailabilityCubit extends Cubit<AvailabilityState> {
  AvailabilityCubit() : super(AvailabilityInitial());

  static AvailabilityCubit get(BuildContext context) =>
      BlocProvider.of<AvailabilityCubit>(context);
      
    

      GetDoctorAvailability? availabilityDays;

  /// submits the list of available slots to the server
  void submitAvailability(List<Map<String, String>> slots)  {
    emit(AvailabilityLoading());
    try {
       Diohelper.PostData(
        url: ApiConstants.doctorAvailability,  // replace with your configured endpoint
        data: {'availableSlots': slots},
        token: CacheHelper.getData(key: 'token')
      );
      // Optionally inspect response, e.g. statusCode or message
      emit(AvailabilitySuccess());
    } catch (e) {
      emit(AvailabilityError(e.toString()));
    }
  }
  void GetDocAvailability()  {
    emit(GetDoctorAvailabilityLoading());
    
     Diohelper.getData(
        url: ApiConstants.GetDoctorAvailability(CacheHelper.getData(key: 'id')),  // replace with your configured endpoint
      ).then((value){
        print(value.data);
        availabilityDays=GetDoctorAvailability.fromJson(value.data);
  
      emit(GetDoctorAvailabilitySuccess(model:availabilityDays! ));

      }).catchError((e){
      emit(GetDoctorAvailabilityError(e.toString()));

      });
      
      // Optionally inspect response, e.g. statusCode or message
    
  }
   void DeleteDocAvailability(slots)  {
    emit(DeleteDoctorAvailabilityLoading());
    
     Diohelper.DeleteData(
      data: {},
      token: CacheHelper.getData(key: "token"),
        url: ApiConstants.DeleteDoctorAvailability(CacheHelper.getData(key: 'id')),  // replace with your configured endpoint
      ).then((value){
        print(value.data);
       
  
      emit(DeleteDoctorAvailabilitySuccess(slots:slots  ));

      }).catchError((e){
      emit(DeleteDoctorAvailabilityError(e.toString()));

      });
      
      // Optionally inspect response, e.g. statusCode or message
    
  }

 Future< void> DeleteAppointmet(String appointmentId)async{
    print(appointmentId);
  emit(DeleteDocAppoimentLoading());
    
    await Diohelper.DeleteData(
      url: ApiConstants.DeleteSpacificDoctorApoiment,  // replace with your configured endpoint
      data: {
        "appointmentId":appointmentId
      },
      token: CacheHelper.getData(key: "token"),
      ).then((value){
        print(value.data);
       
    emit(DeleteDocAppoimentSuccess());

      }).catchError((e){
    emit(DeleteDocAppoimentError(e.toString()));

      });
  }
}
