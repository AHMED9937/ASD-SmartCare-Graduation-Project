// Real app APIs
class ApiConstants {
  /// Base URL for the backend API. Override via --dart-define=API_BASE_URL.
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://asdproject-two.vercel.app/',
  );

  // login
  static const String login = 'api/v1/auth/login';
  static const String getParentData = 'api/v1/parents/getParentData';
  static const String getDoctorData = 'api/v1/doctors/getdoctorData';
  static const String verifyemail = 'api/v1/auth/verifyemail';

  // signUp
  static const String singupForParent = 'api/v1/auth/singupForParent';
  static const String singupForDoctor = 'api/v1/auth/singupForDoctor';
  static String addChild(String id) => 'api/v1/parents/$id/childs';

  // Forget Password
  static const String forgotPasswordEmail = 'api/v1/auth/forgotPassword';
  static const String forgotPasswordEmailVerificationCode =
      'api/v1/auth/verifyPassword';
  static const String resetPassword = 'api/v1/auth/resetPasseword';

  // Delete
  static const String deleteSpecificParent = 'api/v1/parents/';
  static String deleteDoctorAvailability(String id) =>
      'api/v1/appointment/deleteAppointment/$id';
  static const String deleteSpecificDoctorAppointment =
      'api/v1/appointment/deleteAppointment';

  static String deleteSpecificChild(String id) => 'api/v1/childs/$id';

  // Ai
  static const String qsFinalPrediction = 'api/v1/ai/finalPredication';
  static const String qsFinalPredictionDegree =
      'api/v1/ai/finalPredication_degree';
  static const String chatBotReasoning = 'api/v1/ai/chat';

  // get
  static String getAutismLevelTestHistory = 'api/v1/ai/degree_history';
  static String getAutismTestHistory = 'api/v1/ai/autism_history';
  static String getSessionReviewsList(String id) => 'api/v1/sessionReview/$id';
  static String getSpecificSession(String id) => 'api/v1/sessions/$id';
  static const String getDoctorsList = 'api/v1/doctors';
  static const String getAvailableMedicine = 'api/v1/medican';
  static const String getParentBookedDoctors = 'api/v1/appointment/my_doctor';
  static String getAllSessionsForParentAndDoctorByStatus(
    String id,
    String status,
  ) => 'api/v1/sessions/ForParentToOneDoctor/$id/status/$status';
  static String getAvailableEducationArticle = 'api/v1/articles';
  static String getAvailableCharity = 'api/v1/charities';
  static String getAvailableAppointmentForSpecificDoctor(String id) =>
      'api/v1/appointment/getapp/$id';
  static String cancelBooking(String id) => 'api/v1/appointment/cancel/$id';
  static String getDoctorSessionsReviewsList(String id) =>
      'api/v1/doctors/$id/reviews';
  static String getParentDataMe = 'api/v1/parents/getMe';
  static String getParentChildrenList(String id) => 'api/v1/parents/$id/childs';
  static String getDoctorSessionList(String status) =>
      'api/v1/sessions/allSessionsForDoctor/status/$status';
  static String getRegisteredChildrenList =
      'api/v1/appointment/allRegisterParent';
  static String getDoctorAvailabilityById(String id) =>
      'api/v1/appointment/getapp/$id';
  static String getDoctorDataInfo = 'api/v1/doctors/getdoctorData';
  static String getDoctorAppointments =
      'api/v1/appointment/getDoctorAppointments';

  // post
  static String addDoctorReview(String id) => 'api/v1/doctors/$id/reviews';
  static String sessionReview(String id) => 'api/v1/sessionReview/$id';
  static String createSessionCashOrder = 'api/v1/orders';
  static String updateParentProfile = 'api/v1/parents/updateMe';
  static String addChildRequest = 'api/v1/childs';
  static String doctorAvailability = 'api/v1/appointment/createAppointment';
  static String createSessions = 'api/v1/sessions';
  static String bookAppointmentForSpecificDoctor(String id) =>
      'api/v1/appointment/bookAppointment/$id';

  // put
  static String updateLoggedInParentPassword =
      'api/v1/parents/updateMypassword';
  static String updateDoctorProfile = 'api/v1/doctors/updateMe';
  static String updateLoggedInDoctorPassword =
      'api/v1/doctors/updateMypassword';
  static String updateSession(String id) => 'api/v1/sessions/$id';
  static String updateAppointment = 'api/v1/appointment/updateAppointment';

  // payments - IMPORTANT: Use --dart-define or .env for production
  // These are TEST keys only - never commit production keys
  static const String stripeSecretKey = String.fromEnvironment(
    'STRIPE_SECRET_KEY',
    defaultValue: 'sk_test_PLACEHOLDER', // Replace via --dart-define
  );
  static const String stripePublishableKey = String.fromEnvironment(
    'STRIPE_PUBLISHABLE_KEY',
    defaultValue: 'pk_test_PLACEHOLDER', // Replace via --dart-define
  );
  static String genratePaymentSheet(String id) =>
      'api/v1/orders/paymentSheet/$id';

  // Deprecated - use new names above
  @Deprecated('Use stripeSecretKey instead')
  static String get StripeSecretKey => stripeSecretKey;
  @Deprecated('Use stripePublishableKey instead')
  static String get StripPublishablekey => stripePublishableKey;
  @Deprecated('Use genratePaymentSheet instead')
  static String GenrateSPS(String id) => genratePaymentSheet(id);

  // New shims for camelCase migration
  @Deprecated('Use forgotPasswordEmailVerificationCode instead')
  static String get forgotPasswordEmailVerfiationCode =>
      forgotPasswordEmailVerificationCode;
  @Deprecated('Use resetPassword instead')
  static String get ResetPassword => resetPassword;
  @Deprecated('Use deleteSpecificParent instead')
  static String get DeleteSpecificParent => deleteSpecificParent;
  @Deprecated('Use deleteDoctorAvailability instead')
  static String DeleteDoctorAvailability(String id) =>
      deleteDoctorAvailability(id);
  @Deprecated('Use deleteSpecificDoctorAppointment instead')
  static String get DeleteSpacificDoctorApoiment =>
      deleteSpecificDoctorAppointment;
  @Deprecated('Use deleteSpecificChild instead')
  static String DeleteSpacificChild(String id) => deleteSpecificChild(id);
  @Deprecated('Use qsFinalPrediction instead')
  static String get QSfinalPredication => qsFinalPrediction;
  @Deprecated('Use qsFinalPredictionDegree instead')
  static String get QSfinalPredicationDgree => qsFinalPredictionDegree;
  @Deprecated('Use chatBotReasoning instead')
  static String get ChatBotReasoning => chatBotReasoning;
  @Deprecated('Use getAutismLevelTestHistory instead')
  static String get GetAutismLevelTestHistory => getAutismLevelTestHistory;
  @Deprecated('Use getAutismTestHistory instead')
  static String get GetAutismTestHistory => getAutismTestHistory;
  @Deprecated('Use getSessionReviewsList instead')
  static String GetSessionReviewsList(String id) => getSessionReviewsList(id);
  @Deprecated('Use getSpecificSession instead')
  static String GetSpecificSession(String id) => getSpecificSession(id);
  @Deprecated('Use getDoctorsList instead')
  static String get GetDoctorsList => getDoctorsList;
  @Deprecated('Use getAvailableMedicine instead')
  static String get GetAvailableMedicine => getAvailableMedicine;
  @Deprecated('Use getParentBookedDoctors instead')
  static String get GetParentBookedDoctors => getParentBookedDoctors;
  @Deprecated('Use getAllSessionsForParentAndDoctorByStatus instead')
  static String GetAllSessionForSpecificParentAndDoctorByStatus(
    String id,
    String status,
  ) => getAllSessionsForParentAndDoctorByStatus(id, status);
  @Deprecated('Use getAvailableEducationArticle instead')
  static String get GetAvailableEducationArticale =>
      getAvailableEducationArticle;
  @Deprecated('Use getAvailableCharity instead')
  static String get GetAvailableCharity => getAvailableCharity;
  @Deprecated('Use getAvailableAppointmentForSpecificDoctor instead')
  static String GetAvailableApoimentForSpacificDoctor(String id) =>
      getAvailableAppointmentForSpecificDoctor(id);
  @Deprecated('Use cancelBooking instead')
  static String CancelBooking(String id) => cancelBooking(id);
  @Deprecated('Use getParentDataMe instead')
  static String get GetParentData => getParentDataMe;
  @Deprecated('Use getParentChildrenList instead')
  static String GetParentChildsList(String id) => getParentChildrenList(id);
  @Deprecated('Use getDoctorSessionList instead')
  static String GetDoctorSesstionList(String status) =>
      getDoctorSessionList(status);
  @Deprecated('Use getRegisteredChildrenList instead')
  static String get GetRegisteredChildrenList => getRegisteredChildrenList;
  @Deprecated('Use getDoctorAvailabilityById instead')
  static String GetDoctorAvailability(String id) =>
      getDoctorAvailabilityById(id);
  @Deprecated('Use getDoctorDataInfo instead')
  static String get GetDoctorData => getDoctorDataInfo;
  @Deprecated('Use getDoctorAppointments instead')
  static String get GetDoctorAppointments => getDoctorAppointments;
  @Deprecated('Use addDoctorReview instead')
  static String AddDoctorReview(String id) => addDoctorReview(id);
  @Deprecated('Use sessionReview instead')
  static String SessionReview(String id) => sessionReview(id);
  @Deprecated('Use createSessionCashOrder instead')
  static String get CreateSessionCashOrder => createSessionCashOrder;
  @Deprecated('Use addChildRequest instead')
  static String get AddChild => addChildRequest;
  @Deprecated('Use createSessions instead')
  static String get CreateSessions => createSessions;
  @Deprecated('Use bookAppointmentForSpecificDoctor instead')
  static String BookAppointmentForSpecificDoctor(String id) =>
      bookAppointmentForSpecificDoctor(id);
  @Deprecated('Use updateLoggedInParentPassword instead')
  static String get UpdateLogedParentPassword => updateLoggedInParentPassword;
  @Deprecated('Use updateLoggedInDoctorPassword instead')
  static String get UpdateLogedDoctorPassword => updateLoggedInDoctorPassword;
  @Deprecated('Use updateSession instead')
  static String UpdateSession(String id) => updateSession(id);
  @Deprecated('Use updateAppointment instead')
  static String get UpdateAppointment => updateAppointment;
  @Deprecated('Use singupForParent instead')
  static String get signupForParent => singupForParent;
  @Deprecated('Use singupForDoctor instead')
  static String get signupForDoctor => singupForDoctor;
}

class ApiErrors {
  static const String badRequestError = 'badRequestError';
  static const String noContent = 'noContent';
  static const String forbiddenError = 'forbiddenError';
  static const String unauthorizedError = 'unauthorizedError';
  static const String notFoundError = 'notFoundError';
  static const String conflictError = 'conflictError';
  static const String internalServerError = 'internalServerError';
  static const String unknownError = 'unknownError';
  static const String timeoutError = 'timeoutError';
  static const String defaultError = 'defaultError';
  static const String cacheError = 'cacheError';
  static const String noInternetError = 'noInternetError';
  static const String loadingMessage = 'loading_message';
  static const String retryAgainMessage = 'retry_again_message';
  static const String ok = 'Ok';
}
