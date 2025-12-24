import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/auth/signup/controllers/doctor_signup_cubit.dart';
import 'package:flutter/material.dart';

class Doctorsignupform extends StatefulWidget {
  const Doctorsignupform({super.key});

  @override
  State<Doctorsignupform> createState() => _DoctorsignupformState();
}

class _DoctorsignupformState extends State<Doctorsignupform> {
  bool? isChecked = false;
  var spilicationtextcontroller = TextEditingController();

  // Create a TextEditingController for the Date of Birth field
  @override
  Widget build(BuildContext context) {
    return Form(
      child: SizedBox(
        width: 346,
        child: Column(
          children: [
            DropdownButtonFormField(
                focusColor: Colors.white,
                icon: const Image(
                  image: AssetImage(
                      'lib/appassets/images/VectorarrowDown.png'), // Path to your local image
                  width: 20, // Specify width
                  height: 29, // Specify height
                ),
                decoration: InputDecoration(
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage(
                          'lib/appassets/images/Vector.png'), // Path to your local image
                      width: 24, // Specify width
                      height: 24, // Specify height
                    ),
                  ),
                  hintText: 'Enter your Specialization  ',
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(62, 135, 107, 0.42),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'developmental pediatrician',
                    child: Text('developmental pediatrician'),
                  ),
                  DropdownMenuItem(
                    value: 'Neuropsychologist',
                    child: Text('Neuropsychologist'),
                  ),
                  DropdownMenuItem(
                    value: 'Speech-Language Pathologist',
                    child: Text('Speech-Language Pathologist'),
                  ),
                  DropdownMenuItem(
                    value: 'Pediatric Neurologist',
                    child: Text('Pediatric Neurologist'),
                  ),
                ],
                onChanged: (val) {
                  if (val != null) {
                    DoctorSignUpCubit.get(context)
                        .specializationController
                        .text = val;
                  }
                }),
            const SizedBox(height: 20),
            AppTextField(
              hint: 'Enter your Scientific qualifications ',
              controller:
                  DoctorSignUpCubit.get(context).qualificationsController,
              prefixIcon: Icons.school,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () =>
                  DoctorSignUpCubit.get(context).pickMedicalLicenseFile(),
              child: AbsorbPointer(
                child: AppTextField(
                  controller: DoctorSignUpCubit.get(context)
                      .medicalLicenseTextController,
                  hint: 'Choose your Medical license file',
                  readOnly: true,
                  prefixIcon: Icons.upload_file,
                ),
              ),
            ),
            const SizedBox(height: 20),
            AppTextField(
              hint: 'Enter your Clinic address  ',
              controller:
                  DoctorSignUpCubit.get(context).clinicAddressController,
              prefixIcon: Icons.location_on,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
