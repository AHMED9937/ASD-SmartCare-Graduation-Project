import 'dart:io';
import 'package:asdsmartcare/presentation/DoctorLayout/DoctorProfile/editProfile/cubit/edit_doctor_profile_cubit.dart';
import 'package:asdsmartcare/presentation/DoctorLayout/DoctorProfile/editProfile/cubit/edit_doctor_profile_state.dart';
import 'package:asdsmartcare/presentation/DoctorLayout/DoctorProfile/model/GetLoggedDoctorData.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/ParentLayout/profileLayout/screen/ChangePasswordScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';

class EditDoctorProfileScreen extends StatelessWidget {
  final GetLoggedDoctorData DoctorD;
  const EditDoctorProfileScreen({Key? key, required this.DoctorD}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = EditDoctorProfileCubit()..initFrom(DoctorD);
        return cubit;
      },
      child: BlocConsumer<EditDoctorProfileCubit, EditDoctorProfileState>(
        listener: (ctx, state) {
          if (state is EditDoctorProfileSuccessState) {
            ScaffoldMessenger.of(ctx).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
            Navigator.of(ctx).pop();
          }
          if (state is EditDoctorProfileErrorState) {
            ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (ctx, state) {
          final cubit = EditDoctorProfileCubit.get(ctx);

          void _showImageSourceActionSheet() {
            showModalBottomSheet(
              context: ctx,
              builder: (_) => SafeArea(
                child: Wrap(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.camera_alt),
                      title: const Text('Take Photo'),
                      onTap: () {
                        Navigator.of(ctx).pop();
                        cubit.pickPhoto(ImageSource.camera);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Choose from Gallery'),
                      onTap: () {
                        Navigator.of(ctx).pop();
                        cubit.pickPhoto(ImageSource.gallery);
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF133E87), size: 33),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
              centerTitle: true,
              toolbarHeight: 80,
              title: TextUtils.textHeader("Edit Profile", fontSize: 24),
              actions: [
                if (state is EditDoctorProfileLoadingState)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.check, color: Color(0xFF133E87), size: 33),
                    onPressed: cubit.editDoctorProfile,
                  ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                   GestureDetector(
  onTap: _showImageSourceActionSheet,
  child: Container(
    width: 120,
    height: 120,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.grey.shade200,
      border: Border.all(color: Colors.white, width: 3),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: ClipOval(
      child: cubit.pickedImage != null
          ? Image.file(
              cubit.pickedImage!,
              fit: BoxFit.cover,
              width: 120,
              height: 120,
            )
          : (DoctorD.data!.image != null
              ? Image.network(
                  DoctorD.data!.image!,
                  fit: BoxFit.contain,
                  width: 120,
                  height: 120,
                  errorBuilder: (_, __, ___) => Center(
                    child: Icon(Icons.camera_alt, size: 32, color: Colors.grey),
                  ),
                )
              : Center(
                  child: Icon(Icons.camera_alt, size: 32, color: Colors.grey),
                )),
    ),
  ),
),

                    const SizedBox(height: 32),
                    _buildField(label: "Full Name", controller: cubit.nameCtrl),
                    const SizedBox(height: 20),
                    _buildField(label: "Email", controller: cubit.emailCtrl),
                    const SizedBox(height: 20),
                    _buildField(label: "Age", controller: cubit.ageCtrl),
                    const SizedBox(height: 20),
                    _buildField(label: "Address", controller: cubit.addressCtrl),
                    const SizedBox(height: 20),
                    _buildField(label: "Specialization", controller: cubit.DepartmentCtrl),
                    const SizedBox(height: 20),
                    _buildField(label: "Qualifications", controller: cubit.qualificationsCtrl),
                    const SizedBox(height: 20),
                    _buildField(label: "Session Price", controller: cubit.SessionPriceCtrl),
                    const SizedBox(height: 20),
                    
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildField({
    required String label,
    TextEditingController? controller,
    bool readOnly = false,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      obscureText: obscure,
      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF133E87)),
        ),
      ),
    );
  }
}
