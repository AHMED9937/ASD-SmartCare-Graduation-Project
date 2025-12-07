# Fix all import paths after restructuring
$libPath = "c:\Projects\ASD-SmartCare-Graduation-Project\lib"

# Get all dart files
$dartFiles = Get-ChildItem -Path $libPath -Filter "*.dart" -Recurse

# Define import replacements (old path -> new path)
$replacements = @(
    # Auth - Login
    @{Old='features/auth/controllers/login_cubit.dart'; New='shared/auth/login/controllers/login_cubit.dart'},
    @{Old='features/auth/controllers/login_state.dart'; New='shared/auth/login/controllers/login_state.dart'},
    @{Old='features/auth/views/loginscreen.dart'; New='shared/auth/login/views/login_screen.dart'},
    @{Old='features/auth/views/loginform.dart'; New='shared/auth/login/views/login_form.dart'},
    @{Old='features/auth/views/select_login_or_sign_up_screen.dart'; New='shared/auth/login/views/select_auth_screen.dart'},
    @{Old='features/auth/views/select_user_type_screen.dart'; New='shared/auth/login/views/select_role_screen.dart'},
    @{Old='features/auth/models/login_doctor_model.dart'; New='shared/auth/login/models/login_doctor_response.dart'},
    @{Old='features/auth/models/login_parent_model.dart'; New='shared/auth/login/models/login_parent_response.dart'},
    @{Old='features/auth/views/my_rich_text.dart'; New='shared/auth/login/views/auth_rich_text.dart'},
    
    # Auth - Signup
    @{Old='features/auth/controllers/parent_sign_up_cubit.dart'; New='shared/auth/signup/controllers/parent_signup_cubit.dart'},
    @{Old='features/auth/controllers/parent_sign_up_state.dart'; New='shared/auth/signup/controllers/parent_signup_state.dart'},
    @{Old='features/auth/controllers/doctor_cubit.dart'; New='shared/auth/signup/controllers/doctor_signup_cubit.dart'},
    @{Old='features/auth/controllers/doctor_state.dart'; New='shared/auth/signup/controllers/doctor_signup_state.dart'},
    @{Old='features/auth/views/parent_sign_up_screen.dart'; New='shared/auth/signup/views/parent_signup_screen.dart'},
    @{Old='features/auth/views/parent_sign_up_form.dart'; New='shared/auth/signup/views/parent_signup_form.dart'},
    @{Old='features/auth/views/signupform.dart'; New='shared/auth/signup/views/signup_form.dart'},
    @{Old='features/auth/views/doctor_sign_up_screen.dart'; New='shared/auth/signup/views/doctor_signup_screen.dart'},
    @{Old='features/auth/views/doctor_sign_up_form.dart'; New='shared/auth/signup/views/doctor_signup_form.dart'},
    @{Old='features/auth/models/sign_up_parent_model.dart'; New='shared/auth/signup/models/parent_signup_request.dart'},
    @{Old='features/auth/models/signup_model.dart'; New='shared/auth/signup/models/signup_model.dart'},
    @{Old='features/auth/models/sign_up_req_doctor_model.dart'; New='shared/auth/signup/models/doctor_signup_request.dart'},
    @{Old='features/auth/models/sign_up_res_doctor_model.dart'; New='shared/auth/signup/models/doctor_signup_response.dart'},
    @{Old='features/auth/models/add_parent.dart'; New='shared/auth/signup/models/add_parent_request.dart'},
    
    # Auth - Password Reset
    @{Old='features/auth/controllers/forget_password_cubit.dart'; New='shared/auth/password_reset/controllers/password_reset_cubit.dart'},
    @{Old='features/auth/controllers/forget_password_state.dart'; New='shared/auth/password_reset/controllers/password_reset_state.dart'},
    @{Old='features/auth/views/forget_password_screen.dart'; New='shared/auth/password_reset/views/forgot_password_screen.dart'},
    @{Old='features/auth/views/create_new_password_screen.dart'; New='shared/auth/password_reset/views/new_password_screen.dart'},
    @{Old='features/auth/views/password_changed_screen.dart'; New='shared/auth/password_reset/views/password_changed_screen.dart'},
    
    # Auth - Onboarding
    @{Old='features/auth/views/onboarding_navigation_screens.dart'; New='shared/auth/onboarding/views/onboarding_screen.dart'},
    @{Old='features/auth/views/on_boarding_widget.dart'; New='shared/auth/onboarding/views/onboarding_page.dart'},
    
    # Auth - Verification
    @{Old='features/auth/views/otp_verification_screen.dart'; New='shared/auth/verification/views/otp_screen.dart'},
    @{Old='features/auth/views/email_verification_screen.dart'; New='shared/auth/verification/views/email_verification_screen.dart'},
    
    # Auth - Child (moved to parent/my_children)
    @{Old='features/auth/views/add_child_screen.dart'; New='parent/my_children/views/add_child_screen.dart'},
    @{Old='features/auth/views/add_child_form.dart'; New='parent/my_children/views/add_child_form.dart'},
    
    # Auth - Error model (moved to core)
    @{Old='features/auth/models/error_model.dart'; New='core/models/error_model.dart'},
    
    # Medicines
    @{Old='features/medicine/controllers/available_medicine_cubit.dart'; New='shared/medicines/controllers/medicines_cubit.dart'},
    @{Old='features/medicine/controllers/available_medicine_state.dart'; New='shared/medicines/controllers/medicines_state.dart'},
    @{Old='features/medicine/views/available_medicine_screen.dart'; New='shared/medicines/views/medicines_screen.dart'},
    @{Old='features/medicine/views/medicine_info.dart'; New='shared/medicines/views/medicine_details_screen.dart'},
    @{Old='features/medicine/models/medicines_response.dart'; New='shared/medicines/models/medicine_model.dart'},
    
    # Donations
    @{Old='features/donations/controllers/charity_cubit.dart'; New='shared/donations/controllers/charity_cubit.dart'},
    @{Old='features/donations/controllers/charity_state.dart'; New='shared/donations/controllers/charity_state.dart'},
    @{Old='features/donations/views/charity_medicine.dart'; New='shared/donations/views/charities_screen.dart'},
    @{Old='features/donations/views/charity_medicine_info.dart'; New='shared/donations/views/charity_details_screen.dart'},
    @{Old='features/donations/views/charity_info.dart'; New='shared/donations/views/charity_info_screen.dart'},
    @{Old='features/donations/views/available_charity_med.dart'; New='shared/donations/views/charity_medicines_screen.dart'},
    @{Old='features/donations/models/charity_response.dart'; New='shared/donations/models/charity_model.dart'},
    
    # Parent - Find Doctors - Browse
    @{Old='features/doctors/controllers/doctors_list_cubit.dart'; New='parent/find_doctors/browse/controllers/doctors_list_cubit.dart'},
    @{Old='features/doctors/controllers/doctors_list_state.dart'; New='parent/find_doctors/browse/controllers/doctors_list_state.dart'},
    @{Old='features/doctors/views/doctors_list_screen.dart'; New='parent/find_doctors/browse/views/doctors_list_screen.dart'},
    @{Old='features/doctors/models/get_doctors_list_model.dart'; New='parent/find_doctors/browse/models/doctor_model.dart'},
    
    # Parent - Find Doctors - Details
    @{Old='features/doctors/controllers/doctor_review_cubit.dart'; New='parent/find_doctors/details/controllers/doctor_reviews_cubit.dart'},
    @{Old='features/doctors/controllers/doctor_review_state.dart'; New='parent/find_doctors/details/controllers/doctor_reviews_state.dart'},
    @{Old='features/doctors/controllers/session_reviews_cubit.dart'; New='parent/find_doctors/details/controllers/session_reviews_cubit.dart'},
    @{Old='features/doctors/controllers/session_reviews_state.dart'; New='parent/find_doctors/details/controllers/session_reviews_state.dart'},
    @{Old='features/doctors/views/doctor_reviews_widget.dart'; New='parent/find_doctors/details/views/doctor_reviews_screen.dart'},
    @{Old='features/doctors/models/doctor_reviews_model.dart'; New='parent/find_doctors/details/models/doctor_review_model.dart'},
    @{Old='features/doctors/models/get_session_reviews_list.dart'; New='parent/find_doctors/details/models/session_review_model.dart'},
    
    # Parent - Find Doctors - Booking
    @{Old='features/doctors/controllers/booking_cubit.dart'; New='parent/find_doctors/booking/controllers/booking_cubit.dart'},
    @{Old='features/doctors/controllers/booking_state.dart'; New='parent/find_doctors/booking/controllers/booking_state.dart'},
    @{Old='features/doctors/views/reservation_screen.dart'; New='parent/find_doctors/booking/views/booking_screen.dart'},
    @{Old='features/doctors/views/confirm_reservation_screen.dart'; New='parent/find_doctors/booking/views/confirm_booking_screen.dart'},
    @{Old='features/doctors/views/payment_type_screen.dart'; New='parent/find_doctors/booking/views/payment_screen.dart'},
    @{Old='features/doctors/models/appointment_booked.dart'; New='parent/find_doctors/booking/models/booking_response.dart'},
    
    # Parent - Account
    @{Old='features/profile/controllers/parent_data_cubit.dart'; New='parent/account/controllers/parent_profile_cubit.dart'},
    @{Old='features/profile/controllers/parent_data_state.dart'; New='parent/account/controllers/parent_profile_state.dart'},
    @{Old='features/profile/controllers/edit_profile_cubit.dart'; New='parent/account/controllers/edit_profile_cubit.dart'},
    @{Old='features/profile/controllers/edit_profile_state.dart'; New='parent/account/controllers/edit_profile_state.dart'},
    @{Old='features/profile/controllers/change_password_cubit.dart'; New='parent/account/controllers/change_password_cubit.dart'},
    @{Old='features/profile/controllers/change_password_state.dart'; New='parent/account/controllers/change_password_state.dart'},
    @{Old='features/profile/views/profile_screen.dart'; New='parent/account/views/profile_screen.dart'},
    @{Old='features/profile/views/edit_profile.dart'; New='parent/account/views/edit_profile_screen.dart'},
    @{Old='features/profile/views/change_password_screen.dart'; New='parent/account/views/change_password_screen.dart'},
    @{Old='features/profile/models/get_logged_parent_data.dart'; New='parent/account/models/parent_model.dart'},
    
    # Parent - My Children
    @{Old='features/profile/controllers/parentchild_list_cubit.dart'; New='parent/my_children/controllers/children_list_cubit.dart'},
    @{Old='features/profile/controllers/parentchild_list_state.dart'; New='parent/my_children/controllers/children_list_state.dart'},
    @{Old='features/profile/views/parents_childs.dart'; New='parent/my_children/views/children_list_screen.dart'},
    @{Old='features/profile/views/add_child_profile.dart'; New='parent/my_children/views/add_child_profile_screen.dart'},
    @{Old='features/profile/views/add_child_edit_profile.dart'; New='parent/my_children/views/edit_child_screen.dart'},
    @{Old='features/profile/models/parent_childs_model.dart'; New='parent/my_children/models/child_model.dart'},
    
    # Parent - Screening - Test
    @{Old='features/autism_test/controllers/autsium_test_cubit.dart'; New='parent/screening/test/controllers/autism_test_cubit.dart'},
    @{Old='features/autism_test/controllers/autsium_test_state.dart'; New='parent/screening/test/controllers/autism_test_state.dart'},
    @{Old='features/autism_test/controllers/autism_cheker_cubit.dart'; New='parent/screening/test/controllers/autism_checker_cubit.dart'},
    @{Old='features/autism_test/controllers/autism_cheker_state.dart'; New='parent/screening/test/controllers/autism_checker_state.dart'},
    @{Old='features/autism_test/controllers/add_new_child_cubit_cubit.dart'; New='parent/screening/test/controllers/add_child_cubit.dart'},
    @{Old='features/autism_test/controllers/add_new_child_cubit_state.dart'; New='parent/screening/test/controllers/add_child_state.dart'},
    @{Old='features/autism_test/views/autism_test.dart'; New='parent/screening/test/views/autism_test_screen.dart'},
    @{Old='features/autism_test/views/autism_checker.dart'; New='parent/screening/test/views/autism_checker_screen.dart'},
    @{Old='features/autism_test/views/my_audio_recorder.dart'; New='parent/screening/test/views/audio_recorder_screen.dart'},
    @{Old='features/autism_test/models/asd_req_model.dart'; New='parent/screening/test/models/test_request_model.dart'},
    
    # Parent - Screening - Results
    @{Old='features/autism_test/views/ai_evaluation.dart'; New='parent/screening/results/views/ai_evaluation_screen.dart'},
    @{Old='features/autism_test/views/test_result.dart'; New='parent/screening/results/views/test_result_screen.dart'},
    @{Old='features/autism_test/models/prediction_message.dart'; New='parent/screening/results/models/prediction_model.dart'},
    
    # Parent - Screening - History
    @{Old='features/autism_test/controllers/test_history_cubit.dart'; New='parent/screening/history/controllers/test_history_cubit.dart'},
    @{Old='features/autism_test/controllers/test_history_state.dart'; New='parent/screening/history/controllers/test_history_state.dart'},
    @{Old='features/autism_test/models/history_autism_test.dart'; New='parent/screening/history/models/test_history_model.dart'},
    @{Old='features/autism_test/models/history_autism_level_test.dart'; New='parent/screening/history/models/test_level_model.dart'},
    
    # Parent - Progress
    @{Old='features/progress/controllers/child_progress_cubit.dart'; New='parent/progress/controllers/child_progress_cubit.dart'},
    @{Old='features/progress/controllers/child_progress_state.dart'; New='parent/progress/controllers/child_progress_state.dart'},
    @{Old='features/progress/controllers/session_review_cubit.dart'; New='parent/progress/controllers/session_review_cubit.dart'},
    @{Old='features/progress/controllers/session_review_state.dart'; New='parent/progress/controllers/session_review_state.dart'},
    @{Old='features/progress/controllers/doctor_review_cubit.dart'; New='parent/progress/controllers/doctor_review_cubit.dart'},
    @{Old='features/progress/controllers/doctor_review_state.dart'; New='parent/progress/controllers/doctor_review_state.dart'},
    @{Old='features/progress/views/progress.dart'; New='parent/progress/views/progress_screen.dart'},
    @{Old='features/progress/views/session_detail.dart'; New='parent/progress/views/session_details_screen.dart'},
    @{Old='features/progress/views/doctor_review.dart'; New='parent/progress/views/doctor_review_screen.dart'},
    @{Old='features/progress/models/parent_booked_doctors.dart'; New='parent/progress/models/booked_doctors_model.dart'},
    @{Old='features/progress/models/get_all_session.dart'; New='parent/progress/models/session_model.dart'},
    
    # Parent - Chatbot
    @{Old='features/chatbot/controllers/chat_bot_cubit.dart'; New='parent/chatbot/controllers/chatbot_cubit.dart'},
    @{Old='features/chatbot/controllers/chat_bot_state.dart'; New='parent/chatbot/controllers/chatbot_state.dart'},
    @{Old='features/chatbot/views/chat_screen.dart'; New='parent/chatbot/views/chat_screen.dart'},
    @{Old='features/chatbot/models/chat_bot_model.dart'; New='parent/chatbot/models/chat_message_model.dart'},
    
    # Parent - Education
    @{Old='features/education/controllers/education_cubit.dart'; New='parent/education/controllers/articles_cubit.dart'},
    @{Old='features/education/controllers/education_state.dart'; New='parent/education/controllers/articles_state.dart'},
    @{Old='features/education/views/articles.dart'; New='parent/education/views/articles_screen.dart'},
    @{Old='features/education/views/show_article.dart'; New='parent/education/views/article_details_screen.dart'},
    @{Old='features/education/models/education_article_response.dart'; New='parent/education/models/article_model.dart'},
    
    # Parent - Navigation
    @{Old='features/app_start/views/parent_navigation_screen.dart'; New='parent/navigation/parent_navigation_screen.dart'},
    @{Old='features/app_start/controllers/asd_cubit.dart'; New='core/widgets/app_cubit.dart'},
    @{Old='features/app_start/controllers/asd_state.dart'; New='core/widgets/app_state.dart'},
    
    # Doctor - Navigation
    @{Old='features/app_start/views/doctor_navigation_screen.dart'; New='doctor/navigation/doctor_navigation_screen.dart'},
    
    # Doctor - Home
    @{Old='features/doctor_profile/views/doctor_home_screen.dart'; New='doctor/home/views/doctor_home_screen.dart'},
    
    # Doctor - Account
    @{Old='features/doctor_profile/controllers/doctor_profile_data_cubit.dart'; New='doctor/account/controllers/doctor_profile_cubit.dart'},
    @{Old='features/doctor_profile/controllers/doctor_profile_data_state.dart'; New='doctor/account/controllers/doctor_profile_state.dart'},
    @{Old='features/doctor_profile/controllers/edit_doctor_profile_cubit.dart'; New='doctor/account/controllers/edit_profile_cubit.dart'},
    @{Old='features/doctor_profile/controllers/edit_doctor_profile_state.dart'; New='doctor/account/controllers/edit_profile_state.dart'},
    @{Old='features/doctor_profile/views/doctor_profile_screen.dart'; New='doctor/account/views/profile_screen.dart'},
    @{Old='features/doctor_profile/views/edit_doctor_profile_screen.dart'; New='doctor/account/views/edit_profile_screen.dart'},
    @{Old='features/doctor_profile/models/get_logged_doctor_data.dart'; New='doctor/account/models/doctor_model.dart'},
    
    # Doctor - My Patients
    @{Old='features/doctor_profile/controllers/registered_children_cubit.dart'; New='doctor/my_patients/controllers/patients_list_cubit.dart'},
    @{Old='features/doctor_profile/controllers/registered_children_state.dart'; New='doctor/my_patients/controllers/patients_list_state.dart'},
    @{Old='features/doctor_profile/views/registered_children_screen.dart'; New='doctor/my_patients/views/patients_screen.dart'},
    @{Old='features/doctor_profile/models/registered_children.dart'; New='doctor/my_patients/models/patient_model.dart'},
    
    # Doctor - Appointments
    @{Old='features/doctor_profile/controllers/appointments_cubit.dart'; New='doctor/appointments/controllers/appointments_cubit.dart'},
    @{Old='features/doctor_profile/controllers/appointments_state.dart'; New='doctor/appointments/controllers/appointments_state.dart'},
    @{Old='features/doctor_profile/views/appointments_screen.dart'; New='doctor/appointments/views/appointments_screen.dart'},
    @{Old='features/doctor_profile/models/appointments_response.dart'; New='doctor/appointments/models/appointment_model.dart'},
    
    # Doctor - Sessions
    @{Old='features/doctor_profile/controllers/doctor_sessions_cubit.dart'; New='doctor/sessions/list/controllers/sessions_list_cubit.dart'},
    @{Old='features/doctor_profile/controllers/doctor_sessions_state.dart'; New='doctor/sessions/list/controllers/sessions_list_state.dart'},
    @{Old='features/doctor_profile/views/sessions_screen.dart'; New='doctor/sessions/list/views/sessions_screen.dart'},
    @{Old='features/doctor_profile/views/session_management_screen.dart'; New='doctor/sessions/manage/views/session_management_screen.dart'},
    @{Old='features/doctor_profile/views/pdf_viewer_screen.dart'; New='doctor/sessions/manage/views/pdf_viewer_screen.dart'},
    @{Old='features/doctor_profile/models/doctor_sessions.dart'; New='doctor/sessions/list/models/session_model.dart'},
    
    # Doctor - Clinic
    @{Old='features/doctor_profile/controllers/clinic_cubit.dart'; New='doctor/clinic/controllers/clinic_cubit.dart'},
    @{Old='features/doctor_profile/controllers/clinic_state.dart'; New='doctor/clinic/controllers/clinic_state.dart'},
    @{Old='features/doctor_profile/views/clinic_screen.dart'; New='doctor/clinic/views/clinic_screen.dart'},
    @{Old='features/doctor_profile/models/get_doctor_availability.dart'; New='doctor/clinic/models/availability_model.dart'}
)

$filesChanged = 0
$totalReplacements = 0

foreach ($file in $dartFiles) {
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    $fileChanged = $false
    
    foreach ($replacement in $replacements) {
        $oldImport = "package:asdsmartcare/" + $replacement.Old
        $newImport = "package:asdsmartcare/" + $replacement.New
        
        if ($content -match [regex]::Escape($oldImport)) {
            $content = $content -replace [regex]::Escape($oldImport), $newImport
            $fileChanged = $true
            $totalReplacements++
        }
    }
    
    if ($fileChanged) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
        $filesChanged++
        Write-Host "Updated: $($file.FullName)"
    }
}

Write-Host "`n=========================================="
Write-Host "Files updated: $filesChanged"
Write-Host "Total replacements: $totalReplacements"
Write-Host "=========================================="
