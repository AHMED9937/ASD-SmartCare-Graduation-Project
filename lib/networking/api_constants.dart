
// real app apis
class ApiConstants {
  static const String apiBaseUrl="https://asd-final-project-soat.vercel.app/";
  
  // login
  
  static const String login ="api/v1/auth/login";
  static const String getParentData ="api/v1/parents/getParentData";
  static const String getDoctorData ="api/v1/doctors/getdoctorData";
  static const String verifyemail ="api/v1/auth/verifyemail";
  
  // signUp
  static const String singupForParent ="api/v1/auth/singupForParent";
  static const String singupForDoctor ="api/v1/auth/singupForDoctor";
  static String addChild(String id) => 'api/v1/parents/$id/childs';
  
  // Forget Password
  static const String forgotPasswordEmail ="api/v1/auth/forgotPassword";
  static const String forgotPasswordEmailVerfiationCode ="api/v1/auth/verifyPassword";
  static const String ResetPassword="api/v1/auth/resetPasseword";

  // Delete  
  static const String DeleteSpecificParent ="api/v1/parents/";

  static  String DeleteSpacificChild(String id)=>"api/v1/childs/${id}";
  // Ai
    static const String QSfinalPredication ="api/v1/ai/finalPredication";
    static const String QSfinalPredicationDgree ="api/v1/ai/finalPredication_degree";
    static const String ChatBotReasoning="api/v1/ai/chat";
  //get
  static const String GetDoctorsList ="api/v1/doctors";
  static const String GetAvailableMedicine="/api/v1/medican";
  static const String GetParentBookedDoctors  ="/api/v1/appointment/my_doctor";
  static  String GetAllSessionForSpecificParentAndDoctorByStatus(String id,String status)=>"api/v1/sessions/ForParent/${id}/status/${status}";
  static String  GetAvailableEducationArticale="api/v1/articles";
  static String GetAvailableCharity="api/v1/charities";
  static String GetAvailableApoimentForSpacificDoctor(String id)=>"api/v1/appointment/getapp/${id}";
  static String CancelBooking(String id)=> "api/v1/appointment/cancel/${id}";
  static String GetSessionReviewsList(String id)=>"/api/v1/doctors/${id}/reviews";
  static String GetParentData="/api/v1/parents/getMe";
  static String GetParentChildsList(String id)=>"api/v1/parents/${id}/childs";
  static String GetDoctorSesstionList(String status)=>"api/v1/sessions/allSessionsForDoctor/status/${status}";
  static String GetRegisteredChildrenList="api/v1/appointment/allRegisterParent";
  static String GetDoctorAvailability(String id)=>"api/v1/appointment/getapp/${id}";
  //post
  static  String SessionReview(String id)=>"api/v1/sessionReview/${id}";
  static  String CreateSessionCashOrder="api/v1/orders";
  static String updateParentProfile="api/v1/parents/updateMe";
  static String AddChild="api/v1/childs";
  static String doctorAvailability="api/v1/appointment/createAppointment";
  static  String BookAppointmentForSpecificDoctor(String id)=>"api/v1/appointment/bookAppointment/${id}";
  // put
  static String UpdateLogedParentPassword = "api/v1/parents/updateMypassword";
// pyaments
static String StripeSecretKey="sk_test_51RafQ5Q5SEwOJaEx68JlOwqBtDK5qNOXyww3Mi5bSjyeVMfSaeggZIi4SWdTG3xDadTRHJCiXFeR0hKmzhaRbvgl00mpxEQcoa";
static String StripPublishablekey="pk_test_51RafQ5Q5SEwOJaExYMTEDAfH4Ztj6UChkP4ce0I7VtBVeDNvYOvlxYIL9x1wU1uM6tMqfoRxo2JkdWJ2vv9KXgFk007KVUkLM3";
static String  GenrateSPS(String id)=>"api/v1/orders/paymentSheet/${id}";
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}