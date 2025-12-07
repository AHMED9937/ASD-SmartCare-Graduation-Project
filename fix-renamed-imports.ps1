# Fix imports for all renamed files

$replacements = @(
    # app_start
    @{Old='DoctorNavgationScreen'; New='doctor_navigation_screen'},
    @{Old='ParentNavgationScreen'; New='parent_navigation_screen'},
    
    # auth models
    @{Old='AddParent'; New='add_parent'},
    @{Old='ErrorModel'; New='error_model'},
    @{Old='LoginDoctorModel'; New='login_doctor_model'},
    @{Old='loginParentModel'; New='login_parent_model'},
    @{Old='SignupModel '; New='signup_model'},
    @{Old='SignUpParentModel'; New='sign_up_parent_model'},
    @{Old='SignupreqDoctorModel'; New='sign_up_req_doctor_model'},
    @{Old='SignupresDoctorModel'; New='sign_up_res_doctor_model'},
    
    # auth views
    @{Old='AddChildForm'; New='add_child_form'},
    @{Old='AddChildScreen'; New='add_child_screen'},
    @{Old='CreatenewpasswordScreen'; New='create_new_password_screen'},
    @{Old='DoctorSignUpForm'; New='doctor_sign_up_form'},
    @{Old='DoctorSignUpScreen'; New='doctor_sign_up_screen'},
    @{Old='EmailVerfcationScreen'; New='email_verification_screen'},
    @{Old='ForgetPasswordScreen'; New='forget_password_screen'},
    @{Old='my_RichText'; New='my_rich_text'},
    @{Old='onboardingNavgationaScreens'; New='onboarding_navigation_screens'},
    @{Old='onBoardingWidget'; New='on_boarding_widget'},
    @{Old='OTPVerificationScreen'; New='otp_verification_screen'},
    @{Old='ParentSignUpForm'; New='parent_sign_up_form'},
    @{Old='ParentSignUpScreen'; New='parent_sign_up_screen'},
    @{Old='PasswordChangedscreen'; New='password_changed_screen'},
    @{Old='Selectusertypescreen'; New='select_user_type_screen'},
    @{Old='select_Login_or_SignUpScreen'; New='select_login_or_sign_up_screen'},
    
    # autism_test
    @{Old='asdREQmodel'; New='asd_req_model'},
    @{Old='HistoryAustisumLevelTest'; New='history_autism_level_test'},
    @{Old='HistoryAutisumTest'; New='history_autism_test'},
    @{Old='PredictionMessage'; New='prediction_message'},
    @{Old='AiEvaluation'; New='ai_evaluation'},
    @{Old='AutismCheker'; New='autism_checker'},
    @{Old='AutismTest'; New='autism_test'},
    @{Old='MyAudioRecorder'; New='my_audio_recorder'},
    @{Old='TestResult'; New='test_result'},
    
    # chatbot
    @{Old='ChatBotModel'; New='chat_bot_model'},
    @{Old='chatScreen'; New='chat_screen'},
    
    # doctors
    @{Old='Appointmentbooked'; New='appointment_booked'},
    @{Old='DoctorReviewsMoldel'; New='doctor_reviews_model'},
    @{Old='GetDoctorsListModel'; New='get_doctors_list_model'},
    @{Old='GetSessionReviewsList'; New='get_session_reviews_list'},
    @{Old='ConfirmReservationScreen'; New='confirm_reservation_screen'},
    @{Old='doctorReviews'; New='doctor_reviews_widget'},
    @{Old='DoctorsListPage'; New='doctors_list_screen'},
    @{Old='PaymentType'; New='payment_type_screen'},
    @{Old='reservationScreen'; New='reservation_screen'},
    
    # doctor_profile
    @{Old='AppointmentsResponse'; New='appointments_response'},
    @{Old='DoctorSessions'; New='doctor_sessions'},
    @{Old='GetDoctorAvailability'; New='get_doctor_availability'},
    @{Old='GetLoggedDoctorData'; New='get_logged_doctor_data'},
    @{Old='registeredChildern'; New='registered_children'},
    @{Old='RegesterChilds'; New='registered_children_screen'},
    @{Old='clinicScreen'; New='clinic_screen'},
    @{Old='doctorProfile'; New='doctor_profile_screen'},
    @{Old='editDoctorProfile'; New='edit_doctor_profile_screen'},
    @{Old='SessionsScreen'; New='sessions_screen'},
    @{Old='SesstionManagement'; New='session_management_screen'},
    @{Old='viewPdf'; New='pdf_viewer_screen'},
    @{Old='appointment'; New='appointments_screen'},
    @{Old='DoctorHomeScreen'; New='doctor_home_screen'},
    
    # donations
    @{Old='availlableCharityMed'; New='available_charity_med'},
    @{Old='CharitiyMedicanInfo'; New='charity_medicine_info'},
    @{Old='CharityInfo'; New='charity_info'},
    @{Old='CharityMedicine'; New='charity_medicine'},
    @{Old='CharityResponse'; New='charity_response'},
    
    # education
    @{Old='EducationArticaleResponse'; New='education_article_response'},
    @{Old='Articles'; New='articles'},
    @{Old='ShowArticle'; New='show_article'},
    
    # medicine
    @{Old='MedicinesResponse'; New='medicines_response'},
    @{Old='AvailableMedicineScreen'; New='available_medicine_screen'},
    @{Old='MedicenInfo'; New='medicine_info'},
    
    # profile
    @{Old='GetLoggedParentData'; New='get_logged_parent_data'},
    @{Old='ParentChildsModel'; New='parent_childs_model'},
    @{Old='AddchildEditProfile'; New='add_child_edit_profile'},
    @{Old='AddchildProfile'; New='add_child_profile'},
    @{Old='ChangePasswordScreen'; New='change_password_screen'},
    @{Old='EditProfile'; New='edit_profile'},
    @{Old='ParentsChilds'; New='parents_childs'},
    @{Old='profileScreen'; New='profile_screen'},
    
    # progress
    @{Old='GetAllSession'; New='get_all_session'},
    @{Old='ParentBookedDoctors'; New='parent_booked_doctors'},
    @{Old='DoctorReview'; New='doctor_review'},
    @{Old='SessionDeatile'; New='session_detail'}
)

Write-Host "Fixing import statements for renamed files..."

$dartFiles = Get-ChildItem -Path "lib" -Filter "*.dart" -Recurse

$totalFiles = 0
$totalReplacements = 0

foreach ($file in $dartFiles) {
    $content = Get-Content -Path $file.FullName -Raw -ErrorAction SilentlyContinue
    
    if ($null -eq $content) {
        continue
    }
    
    $originalContent = $content
    $fileChanged = $false
    
    foreach ($replacement in $replacements) {
        $oldName = $replacement.Old
        $newName = $replacement.New
        
        # Replace in import/export statements (package: style)
        # Match: package:asdsmartcare/features/.../OldName.dart
        $pattern = "(?<=/)$oldName(?=\.dart)"
        if ($content -match $pattern) {
            $content = $content -replace $pattern, $newName
            $fileChanged = $true
            $totalReplacements++
        }
    }
    
    if ($fileChanged) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
        $totalFiles++
        Write-Host "  Updated: $($file.FullName -replace [regex]::Escape($PWD.Path + '\'), '')"
    }
}

Write-Host "`nCompleted: $totalReplacements replacements in $totalFiles files"
