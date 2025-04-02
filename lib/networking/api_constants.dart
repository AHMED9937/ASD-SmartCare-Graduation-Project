
// real app apis
class ApiConstants {
  static const String apiBaseUrl="https://asd-final-project-soat.vercel.app/";
  
  // login
  
  static const String login ="api/v1/auth/login";
  static const String Parentlogin ="api/v1/auth/loginForParent";
  static const String doctorlogin ="api/v1/auth/loginForDoctor";
  static const String getParentData ="api/v1/parents/getParentData";
  static const String getDoctorData ="api/v1/doctors/getdoctorData";
  static const String verifyemail ="api/v1/auth/verifyemail";
  
  // signUp
  static const String singupForUser ="api/v1/auth/singupForUser";
  static const String singupForParent ="api/v1/auth/singupForParent";
  static const String singupForDoctor ="api/v1/auth/singupForDoctor";
  static const String GetDoctorsList ="api/v1/doctors";



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