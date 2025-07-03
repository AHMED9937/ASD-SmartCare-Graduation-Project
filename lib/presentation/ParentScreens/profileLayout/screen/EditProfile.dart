import 'dart:io';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/controller/cubit/EditProfile/edit_profile_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/screen/AddchildEditProfile.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/screen/ChangePasswordScreen.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/Model/GetLoggedParentData.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/widgets/ParentsChilds.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/controller/cubit/EditProfile/edit_profile_state.dart';

class EditProfileScreen extends StatelessWidget {
  final GetLoggedParentData parentD;
  const EditProfileScreen({Key? key, required this.parentD}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = EditParentProfileCubit()..initFrom(parentD);
        return cubit;
      },
      child: BlocConsumer<EditParentProfileCubit, EditParentProfileState>(
        listener: (ctx, state) {
          
          if (state is EditParentProfileSuccessState) {
            ScaffoldMessenger.of(ctx).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
            Navigator.of(ctx).pop();
          }
          if (state is EditParentProfileErrorState) {
            ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
          
        },
        builder: (ctx, state) {
          final cubit = EditParentProfileCubit.get(ctx);

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
                icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF133E87),size: 33),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
              centerTitle: true,

              toolbarHeight: 80,
              title: TextUtils.textHeader("Edit Profile", fontSize: 24),
              actions: [
                if (state is EditParentProfileLoadingState)
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
                    icon: const Icon(Icons.check, color: Color(0xFF133E87),size: 33),
                    onPressed: cubit.editParentProfile,
                  ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _showImageSourceActionSheet,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: cubit.pickedImage != null
                          ? FileImage(cubit.pickedImage!)
                          : (parentD.data!.image != null
                              ? NetworkImage(parentD.data!.image!)
                              : null) as ImageProvider?,
                      child: cubit.pickedImage == null && parentD.data!.image == null
                          ? const Icon(Icons.camera_alt, size: 32, color: Colors.grey)
                          : null,
                    ),
                  ),

                  const SizedBox(height: 32),
                  _buildField(label: "Full Name", controller: cubit.nameCtrl),
                  const SizedBox(height: 20),
                  _buildField(label: "Phone", controller: cubit.phoneCtrl),
                  const SizedBox(height: 20),
                  _buildField(label: "Email", controller: cubit.emailCtrl),
                  const SizedBox(height: 20),
                  _buildField(label: "Age", controller: cubit.ageCtrl),
                  const SizedBox(height: 20),
                  _buildField(label: "Address", controller: cubit.addressCtrl),
                  const SizedBox(height: 20),
                   _buildField(label: "Password",suffix: IconButton(onPressed: ()=>NavgatTO(context, ChangePasswordScreen()), icon: Icon(Icons.arrow_forward_outlined))),
                  const SizedBox(height: 20),
 AppButtons.containerTextButton(
                    TextUtils.textHeader("Childs Management",headerTextColor: Colors.white,),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Addchildeditprofile(
                            ParentId: parentD.data!.id!,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildField({
    required String label,
     TextEditingController ?controller,
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
