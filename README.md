
# ASD Smart Care Flutter Project Overview           

## 1. Project Summary

**ASD SmartCare** is a cross‑platform Flutter application designed to support autism assessment and care. It integrates multiple modules for autism screening, Q&A chatbot interactions, doctor recommendations, session tracking, and more. The app aims to facilitate specialists and caregivers in monitoring, guiding, and managing autism-related activities for children.

## 2. Goals and Scope

- **AI‑Powered Autism Detection**: Conversational Q&A (text and voice) to screen for autism.
- **Specialized Chatbot**: Answers questions about autism, therapeutic techniques, and child development.
- **Doctor Recommendation & Booking**: Tailored specialist listings and in‑app appointment scheduling.
- **Child Progress Tracker**: Specialists log session outcomes and update development metrics.
- **Educational Hub**: Practical parenting guidance, materials, and tutorials.
- **Medicine Guide**: Nearby pharmacy suggestions and prescription management.
- **Charity Section**: Connects families to free medication programs and nonprofit autism associations.

## 3. Key Features

- **Authentication & Authorization**  
  Two‑role system (Specialist, Caregiver) with secure Flutter auth flows.

- **State Management**  
  Bloc/Cubit covering error, loading, and null states.

- **Media Integration**  
  Audio recording/playback, file & image upload

- **AI Tools**  
  NLP‑based Q&A system and hybrid classification models for autism screening.

- **CRUD Operations**  
  Full create/read/update/delete support for assessments, profiles, sessions, etc.

- **Stripe Payments**  
  Integration for subscriptions or one‑off service fees.

- **Platform Support**  
  Builds for Android, iOS, Web, Windows, and macOS.

## 4. Architecture & Technologies

- **Frontend**: Flutter (Dart) with Bloc/Cubit.  
- **Backend**: RESTful APIs (e.g., Node.js) for AI inference, data persistence, payments.  
- **AI Services**: Deployed NLP models accessed via HTTP endpoints.  
- **Data Storage**: Cloud database (Firebase, MongoDB) for users, sessions, metrics.  
- **CI/CD**: GitHub Actions (configured under `ci/`).

## 5. Directory Structure
   ├── lib/
    │   ├── main.dart
    │   ├── tempCodeRunnerFile.dart
    │   ├── appassets/
    │   │   └── images/
    │   ├── appDesign/
    │   │   └── weak1_part1 design(fixed_widgets+onboarding).txt
    │   ├── appShared/
    │   │   ├── cacheHelper/
    │   │   │   └── cahcheHelper.dart
    │   │   ├── Components/
    │   │   │   ├── myblockob.dart
    │   │   │   └── SharedComponents.dart
    │   │   └── remote/
    │   │       └── diohelper.dart
    │   ├── networking/
    │   │   ├── api_constants.dart
    │   │   ├── api_error_handler.dart
    │   │   ├── api_error_model.dart
    │   │   ├── api_error_model.g.dart
    │   │   ├── api_result.dart
    │   │   ├── api_result.freezed.dart
    │   │   └── dio_factory.dart
    │   └── presentation/
    │       ├── AfterLoginRootes/
    │       │   ├── apphome/
    │       │   │   ├── appHome.dart
    │       │   │   └── Education/
    │       │   │       ├── Articles.dart
    │       │   │       └── ShowArticle.dart
    │       │   ├── AsdAppLayouts/
    │       │   │   ├── cubit/
    │       │   │   │   ├── asd_cubit.dart
    │       │   │   │   └── asd_state.dart
    │       │   │   └── screens/
    │       │   │       └── BottomNavgationScreen.dart
    │       │   ├── chatLayout/
    │       │   │   └── screen/
    │       │   │       └── chatScreen.dart
    │       │   ├── DoctorLayout/
    │       │   │   ├── DoctorBooking/
    │       │   │   │   └── Screens/
    │       │   │   │       ├── ConfirmReservationScreen.dart
    │       │   │   │       ├── PaymentsCheckScreen.dart
    │       │   │   │       └── reservationScreen.dart
    │       │   │   └── DoctorsList/
    │       │   │       ├── cubit/
    │       │   │       │   ├── doctors_list_cubit.dart
    │       │   │       │   └── doctors_list_state.dart
    │       │   │       ├── model/
    │       │   │       │   └── GetDoctorsListModel.dart
    │       │   │       └── screen/
    │       │   │           └── DoctorsListPage.dart
    │       │   ├── EvaluateLayout/
    │       │   │   └── screens/
    │       │   │       └── Evaluate.dart
    │       │   ├── profileLayout/
    │       │   │   └── screen/
    │       │   │       └── profileScreen.dart
    │       │   └── progressLayout/
    │       │       └── screens/
    │       │           └── progress.dart
    │       ├── Fixed_Widgets/
    │       │   ├── app_Buttons.dart
    │       │   ├── AppFormTextField.dart
    │       │   ├── appImages.dart
    │       │   ├── colorUtils.dart
    │       │   ├── FixedWidgets.dart
    │       │   ├── phoneScreenUtils.dart
    │       │   └── TextUtils.dart
    │       ├── login/
    │       │   ├── LoginCubits/
    │       │   │   └── Usercubit/
    │       │   │       ├── login_cubit.dart
    │       │   │       └── login_state.dart
    │       │   ├── model/
    │       │   │   ├── LoginDoctorModel.dart
    │       │   │   ├── loginModel.dart
    │       │   │   └── loginParentModel.dart
    │       │   ├── screen/
    │       │   │   ├── CreatenewpasswordScreen.dart
    │       │   │   ├── ForgetPasswordScreen.dart
    │       │   │   ├── loginscreen.dart
    │       │   │   ├── OTPVerificationScreen.dart
    │       │   │   ├── PasswordChangedscreen.dart
    │       │   │   ├── select_Login_or_SignUpScreen.dart
    │       │   │   └── SelectUserTypeScreen.dart
    │       │   └── widgets/
    │       │       ├── loginform.dart
    │       │       └── my_RichText.dart
    │       ├── onBoarding/
    │       │   ├── onboardingNavgationaScreens.dart
    │       │   └── onBoardingWidget.dart
    │       └── SignUp/
    │           ├── cubit/
    │           │   ├── DoctorCubit/
    │           │   │   ├── doctor_cubit.dart
    │           │   │   └── doctor_state.dart
    │           │   └── Parentcubit/
    │           │       ├── parent_sign_up_cubit.dart
    │           │       └── parent_sign_up_state.dart
    │           ├── Model/
    │           │   ├── ErrorModel.dart
    │           │   ├── SignupModel .dart
    │           │   ├── SignUpParentModel.dart
    │           │   ├── SignupreqDoctorModel.dart
    │           │   └── SignupresDoctorModel.dart
    │           ├── screen/
    │           │   ├── DoctorSignUpScreen.dart
    │           │   ├── EmailVerfcationScreen.dart
    │           │   └── ParentSignUpScreen.dart
    │           └── Widgets/
    │               ├── DoctorSignUpForm.dart
    │               ├── ParentSignUpForm.dart
    │               └── signupform.dart

## 6. Setup & Installation

1. **Prerequisites**: Flutter SDK (>=2.0), Dart SDK, Android Studio, Xcode, etc.
2. **Clone the Repo**  
   ```bash
   git clone <repo-url>
   cd asdsmartcare
   ```
3. **Install Dependencies**  
   ```bash
   flutter pub get
   ```
4. **Configure Environment**  
   - Copy `example.env` to `.env`  
   - Fill in API keys (AI server URL, Stripe keys, etc.)
5. **Run on Device/Emulator**  
   ```bash
   flutter run
   ```

## 7. Usage & Workflows

- **Autism Assessment**: “AI Test” → record responses → submit → view results.  
- **Chatbot**: “Ask a Question” → receive autism advice.  
- **Booking**: “Doctors” tab → search → view availability → book.  
- **Session Tracker**: “Progress” → log session outcomes.


## 8. License

Released under the MIT License. See `LICENSE` for details.
