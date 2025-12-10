import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/my_children/views/add_child_screen.dart';
import 'package:asdsmartcare/shared/auth/signup/controllers/parent_signup_cubit.dart';
import 'package:asdsmartcare/shared/auth/signup/controllers/parent_signup_state.dart';
import 'package:asdsmartcare/shared/auth/signup/views/doctor_signup_screen.dart';
import 'package:asdsmartcare/shared/auth/verification/views/widgets/email_verification_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Emailverfcationscreen extends StatefulWidget {
  final String parentID;
  final String parentUserName;
  final String parentEmail;
  final ParentSignUpCubit? cubit;
  const Emailverfcationscreen({
    super.key,
    required this.parentID,
    required this.parentUserName,
    required this.parentEmail,
    this.cubit,
  });

  @override
  State<Emailverfcationscreen> createState() => _EmailverfcationscreenState();
}

class _EmailverfcationscreenState extends State<Emailverfcationscreen> {
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.cubit ?? ParentSignUpCubit(),
      child: BlocConsumer<ParentSignUpCubit, ParentSignUpState>(
        listener: (context, state) {
          if (state is DeleteParentSuccessState) {
            Navigator.pop(context);
          }

          if (state is ParentSignUpresetCodeSuccessState) {
            _showSuccess(context);
          } else if (state is ParentSignUpresetCodeErrorState) {
            setState(() {
              _errorMessage = 'Invalid Verification Code';
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Invalid Code'),
                backgroundColor: AppColors.error,
              ),
            );
          } else if (state is ParentSignUpresetCodeLoadingState) {
            setState(() {
              _errorMessage = null;
            });
          }

          // Handle Resend States
          if (state is ResendCodeSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Code sent successfully!'),
                backgroundColor: AppColors.success,
              ),
            );
          } else if (state is ResendCodeErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to resend: ${state.error}'),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = ParentSignUpCubit.get(context);
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, dynamic result) async {
              if (didPop) return;

              // Delete Parent on Back Press
              cubit.DeleteParent(
                ParentId: widget.parentID,
                ParentUserName: widget.parentUserName,
              );
              // Note: Navigation pop will happen in BlocListener success state
            },
            child: Scaffold(
              appBar: AppHeader.transparent(
                leading: GestureDetector(
                  onTap: () {
                    // Delete parent before navigating back
                    cubit.DeleteParent(
                      ParentId: widget.parentID,
                      ParentUserName: widget.parentUserName,
                    );
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withValues(alpha: 0.12),
                          AppColors.primary.withValues(alpha: 0.06),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              body: SafeArea(
                child: EmailVerificationBody(
                  email: widget.parentEmail,
                  isLoading:
                      state is ParentSignUpresetCodeLoadingState ||
                      state is ResendCodeLoadingState,
                  errorMessage: _errorMessage,
                  onSubmit: (code) {
                    cubit.verificationCode = code;
                    cubit.verifyemail();
                  },
                  onCodeChanged: (code) {
                    cubit.verificationCode = code;
                    if (_errorMessage != null) {
                      setState(() {
                        _errorMessage = null;
                      });
                    }
                  },
                  onVerify: () {
                    cubit.verifyemail();
                  },
                  onResend: () {
                    cubit.resendCode(email: widget.parentEmail);
                  },
                  onChangeEmail: () {
                    cubit.DeleteParent(
                      ParentId: widget.parentID,
                      ParentUserName: widget.parentUserName,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSuccess(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: AppColors.success,
                size: 64,
              ),
              const SizedBox(height: 16),
              const Text(
                'Verified!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your account has been successfully verified.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'Continue',
                onPressed: () {
                  // Logic from original code
                  if (CacheHelper.getData(key: 'role') == 'parent') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddChildScreen(parentId: widget.parentID),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Doctorsignupscreen(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
