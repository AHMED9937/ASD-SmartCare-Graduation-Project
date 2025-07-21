
# Autistic Spectrum Disorders Smart Care Flutter Project Overview           


## 1. Project Summary

**ASD SmartCare** is a cross‑platform Flutter application designed to support autism assessment and care. It integrates multiple modules for autism screening, Q&A chatbot interactions, doctor recommendations, session tracking, and more. The app aims to facilitate specialists and caregivers in monitoring, guiding, and managing autism-related activities for children.

📥 [Download the APK](https://drive.google.com/file/d/1cRxrZ3s-ED3sZGo-PKvzXYpOMsQg_nf3/view)
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
  Builds for Android, iOS

## 4. Architecture & Technologies

- **Frontend**: Flutter (Dart) with Bloc/Cubit.  
- **Backend**: RESTful APIs (e.g., Node.js) for AI inference, data persistence, payments.  
- **AI Services**: Deployed NLP models accessed via HTTP endpoints.  
- **Data Storage**: Cloud database (Firebase, MongoDB) for users, sessions, metrics.  
- **CI/CD**: GitHub Actions (configured under `ci/`).

## 5. Directory Structure

```plaintext
/ (root)
├── android/                                  # Android platform code and Gradle scripts
├── ios/                                      # iOS platform code and Xcode configurations
├── macos/                                    # macOS platform code
├── windows/                                  # Windows platform code
├── web/                                      # Web build support
└── lib/                                      # Main Flutter application code
    ├── main.dart
    ├── temp_code_runner_file.dart
    ├── assets/
    │   └── images/
    ├── design/
    │   └── weak1_part1_design_fixed_widgets_onboarding.txt
    ├── shared/
    │   ├── cache/
    │   │   └── cache_helper.dart
    │   ├── components/
    │   │   ├── my_block_ob.dart
    │   │   └── shared_components.dart
    │   └── remote/
    │       └── dio_helper.dart
    ├── networking/
    │   ├── api_constants.dart
    │   ├── api_error_handler.dart
    │   ├── api_error_model.dart
    │   ├── api_error_model.g.dart
    │   ├── api_result.dart
    │   ├── api_result.freezed.dart
    │   └── dio_factory.dart
    └── presentation/
        ├── after_login_routes/
        │   ├── app_home/
        │   │   ├── app_home.dart
        │   │   └── education/
        │   │       ├── articles.dart
        │   │       └── show_article.dart
        │   ├── asd_app_layouts/
        │   │   ├── cubit/
        │   │   │   ├── asd_cubit.dart
        │   │   │   └── asd_state.dart
        │   │   └── screens/
        │   │       └── bottom_navigation_screen.dart
        │   ├── chat_layout/
        │   │   └── screens/
        │   │       └── chat_screen.dart
        │   ├── doctor_layout/
        │   │   ├── doctor_booking/
        │   │   │   └── screens/
        │   │   │       ├── confirm_reservation_screen.dart
        │   │   │       ├── payments_check_screen.dart
        │   │   │       └── reservation_screen.dart
        │   │   └── doctors_list/
        │   │       ├── cubit/
        │   │       │   ├── doctors_list_cubit.dart
        │   │       │   └── doctors_list_state.dart
        │   │       ├── model/
        │   │       │   └── get_doctors_list_model.dart
        │   │       └── screens/
        │   │           └── doctors_list_page.dart
        │   ├── evaluate_layout/
        │   │   └── screens/
        │   │       └── evaluate.dart
        │   ├── profile_layout/
        │   │   └── screens/
        │   │       └── profile_screen.dart
        │   └── progress_layout/
        │       └── screens/
        │           └── progress.dart
        ├── fixed_widgets/
        │   ├── app_buttons.dart
        │   ├── app_form_text_field.dart
        │   ├── app_images.dart
        │   ├── color_utils.dart
        │   ├── fixed_widgets.dart
        │   ├── phone_screen_utils.dart
        │   └── text_utils.dart
        ├── login/
        │   ├── cubits/
        │   │   └── user_cubit/
        │   │       ├── login_cubit.dart
        │   │       └── login_state.dart
        │   ├── models/
        │   │   ├── login_doctor_model.dart
        │   │   ├── login_model.dart
        │   │   └── login_parent_model.dart
        │   ├── screens/
        │   │   ├── create_new_password_screen.dart
        │   │   ├── forget_password_screen.dart
        │   │   ├── login_screen.dart
        │   │   ├── otp_verification_screen.dart
        │   │   ├── password_changed_screen.dart
        │   │   ├── select_login_or_sign_up_screen.dart
        │   │   └── select_user_type_screen.dart
        │   └── widgets/
        │       ├── login_form.dart
        │       └── rich_text.dart
        ├── onboarding/
        │   ├── onboarding_navigation_screens.dart
        │   └── onboarding_widget.dart
        └── signup/
            ├── cubits/
            │   ├── doctor_cubit/
            │   │   ├── doctor_cubit.dart
            │   │   └── doctor_state.dart
            │   └── parent_cubit/
            │       ├── parent_sign_up_cubit.dart
            │       └── parent_sign_up_state.dart
            ├── models/
            │   ├── error_model.dart
            │   ├── signup_model.dart
            │   ├── sign_up_parent_model.dart
            │   ├── signup_req_doctor_model.dart
            │   └── signup_res_doctor_model.dart
            ├── screens/
            │   ├── doctor_sign_up_screen.dart
            │   ├── email_verification_screen.dart
            │   └── parent_sign_up_screen.dart
            └── widgets/
                ├── doctor_sign_up_form.dart
                ├── parent_sign_up_form.dart
                └── signup_form.dart


```
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
