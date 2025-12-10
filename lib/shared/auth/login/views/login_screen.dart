import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asdsmartcare/app/router/app_router.dart';
import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/auth/login/controllers/login_cubit.dart';
import 'package:asdsmartcare/shared/auth/login/controllers/login_state.dart';
import 'package:asdsmartcare/shared/auth/login/models/login_doctor_response.dart';
import 'package:asdsmartcare/shared/auth/login/models/login_parent_response.dart';
import 'package:asdsmartcare/shared/auth/login/views/widgets/login_body.dart';

/// Login screen using shared UI components and design system tokens.
///
/// Demonstrates:
/// - Centralized theming via [AppColors], [AppTypography], [AppSpacing]
/// - Shared UI components: [AppTextField], [AppButton], [LoadingView], [ErrorView]
/// - Cubit-based state management with clear state handling
/// - Centralized routing via [AppRoutes]
class LoginScreen extends StatelessWidget {
  final UserLoginCubit? cubit;

  const LoginScreen({super.key, this.cubit});

  @override
  Widget build(BuildContext context) {
    if (cubit != null) {
      return BlocProvider.value(
        value: cubit!,
        child: const _LoginScreenContent(),
      );
    }
    return BlocProvider(
      create: (_) => UserLoginCubit(),
      child: const _LoginScreenContent(),
    );
  }
}

class _LoginScreenContent extends StatefulWidget {
  const _LoginScreenContent();

  @override
  State<_LoginScreenContent> createState() => _LoginScreenContentState();
}

class _LoginScreenContentState extends State<_LoginScreenContent> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<UserLoginCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  void _handleLoginSuccess(LoginSuccess state) {
    final token = state.userModel.token as String;
    final role = state.userModel.data.role;
    final id = state.userModel.data.id;

    // Get userName based on role
    String? userName;
    if (state.userModel is LoginParentModel) {
      userName = (state.userModel as LoginParentModel).data?.userName;
    } else if (state.userModel is LoginDoctorModel) {
      userName = (state.userModel as LoginDoctorModel).data?.parent?.userName;
    }

    // Clear previous session data
    CacheHelper.removeData(key: 'degree_prediction');
    CacheHelper.removeData(key: 'AsdLevel');

    // Save new session data
    CacheHelper.saveData(key: 'role', value: role);
    CacheHelper.saveData(key: 'id', value: id);
    if (userName != null) {
      CacheHelper.saveData(key: 'userName', value: userName);
    }
    CacheHelper.saveData(key: 'token', value: token).then((_) {
      if (!mounted) return;
      // Navigate using centralized routes
      final targetRoute = role == 'parent'
          ? AppRoutes.parentHome
          : AppRoutes.doctorHome;
      Navigator.pushNamedAndRemoveUntil(context, targetRoute, (route) => false);
    });
  }

  void _handleLoginError(LoginError state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.error,
        content: Text(
          state.error,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.onError),
        ),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: AppColors.onError,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLoginCubit, UserLoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          _handleLoginSuccess(state);
        } else if (state is LoginError) {
          _handleLoginError(state);
        }
      },
      builder: (context, state) {
        // Check if we can actually pop - this handles edge cases where
        // canPop might return true but there's no meaningful route to go back to
        final canGoBack =
            Navigator.canPop(context) &&
            ModalRoute.of(context)?.isFirst != true;

        return Scaffold(
          appBar: AppHeader(
            title: '',
            elevation: 0,
            backgroundColor: AppColors.transparent,
            showBackButton: canGoBack,
          ),
          body: SafeArea(
            child: LoginBody(
              formKey: _formKey,
              emailController: _emailController,
              passwordController: _passwordController,
              rememberMe: _rememberMe,
              onRememberMeChanged: (value) {
                setState(() {
                  _rememberMe = value ?? false;
                });
                CacheHelper.saveData(key: 'rememberMe', value: _rememberMe);
              },
              emailValidator: _validateEmail,
              passwordValidator: _validatePassword,
              onLoginPressed: _handleLogin,
              onForgotPasswordPressed: () {
                Navigator.pushNamed(context, AppRoutes.forgotPassword);
              },
              onSignUpPressed: () {
                Navigator.pushNamed(context, AppRoutes.selectRole);
              },
              isLoading: state is LoginLoading,
            ),
          ),
        );
      },
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
