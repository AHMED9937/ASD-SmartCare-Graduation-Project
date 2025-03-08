
// real app apis
class ApiConstants {
  static const String apiBaseUrl="https://asd-final-project-cr777.vercel.app/";
  static const String login ="api/v1/auth/login";
  static const String Parentlogin ="api/v1/auth/loginForParent";
  static const String doctorlogin ="api/v1/auth/loginForDoctor";
  static const String getParentData ="api/v1/parents/getParentData";
  static const String getDoctorData ="api/v1/doctors/getdoctorData";
  
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