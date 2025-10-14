import 'package:asdsmartcare/app/router/app_router.dart';
import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/shared/auth/login/views/widgets/select_user_type_body.dart';
import 'package:flutter/material.dart';

class Selectusertypescreen extends StatelessWidget {
  const Selectusertypescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SelectUserTypeBody(
          onSelectDoctor: () {
            CacheHelper.saveData(key: 'role', value: 'doctor');
            Navigator.pushNamed(context, AppRoutes.registerParent);
          },
          onSelectParent: () {
            CacheHelper.saveData(key: 'role', value: 'parent');
            Navigator.pushNamed(context, AppRoutes.registerParent);
          },
        ),
      ),
    );
  }
}
