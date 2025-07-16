import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/SignUp/cubit/DoctorCubit/doctor_cubit.dart';
import 'package:asdsmartcare/presentation/SignUp/cubit/Parentcubit/parent_sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Doctorsignupform extends StatefulWidget {
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
              icon: Image(
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
               
               hintText: "Enter your Specialization  ",
               hintStyle: TextStyle(
                
                color: Color.fromRGBO(62, 135, 107, 0.42),
               ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      
                ),
                items: 
                const[
                  DropdownMenuItem(
                    child: Text("developmental pediatrician"),
                    value: "developmental pediatrician",
                  ), DropdownMenuItem(
                    child: Text("Neuropsychologist"),
                    value: "Neuropsychologist",
                  ), DropdownMenuItem(
                    child: Text("Speech-Language Pathologist"),
                    value: "Speech-Language Pathologist",
                  ), DropdownMenuItem(
                    child: Text("Pediatric Neurologist"),
                    value: "Pediatric Neurologist",
                  ),
               
                ],
                onChanged: (val) {
                  if (val!=null)
                  DoctorSignUpCubit.get(context).specializationController.text=val;

                }),
             const SizedBox(height: 20),
            Appformtextfield(
              //  TextController: ParentSignUpCubit.get(context).childNametextcontroller,
              hintText: "Enter your Scientific qualifications ",
              TextController:DoctorSignUpCubit.get(context).qualificationsController ,
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage(
                      'lib/appassets/images/qualifications.png'), // Path to your local image
                  width: 24, // Specify width
                  height: 24, // Specify height
                ),
              ),
            ),
            const SizedBox(height: 20),
            Appformtextfield(
               TextController:DoctorSignUpCubit.get(context).medicalLicenseTextController,
               pickFile:DoctorSignUpCubit.get(context).pickMedicalLicenseFile ,
                hintText: "Choose your Medical license file",
              isFilePicker: true, // Enable file picker functionality
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage(
                      'lib/appassets/images/material-symbols_upload.png'), // Path to your local image
                  width: 24, // Specify width
                  height: 24, // Specify height
                ),
              ),
            ),
            const SizedBox(height: 20),
            Appformtextfield(
              //  TextController: ParentSignUpCubit.get(context).childNametextcontroller,
              hintText: "Enter your Clinic address  ",
              TextController: DoctorSignUpCubit.get(context).clinicAddressController,
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage(
                      'lib/appassets/images/mdi_address-marker.png'), // Path to your local image
                  width: 24, // Specify width
                  height: 24, // Specify height
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
