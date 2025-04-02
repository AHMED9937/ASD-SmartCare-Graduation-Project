import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/signupCubits/cubit/Parentcubit/parent_sign_up_cubit.dart';
import 'package:asdsmartcare/presentation/signupCubits/cubit/sign_up_cubit.dart';
import 'package:asdsmartcare/presentation/signupCubits/cubit/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Parentsignupform extends StatelessWidget {
  bool? isChecked = false;

  // Create a TextEditingController for the Date of Birth field
  

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SizedBox(
        width: 346,
        child: Column(
          children: [
            Appformtextfield(
              TextController: ParentSignUpCubit.get(context).childNametextcontroller,
              hintText: "Enter your Child name  ",
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage(
                      'lib/appassets/images/editname.png'), // Path to your local image
                  width: 24, // Specify width
                  height: 24, // Specify height
                ),
              ),
            ),
            const SizedBox(height: 20),
            Appformtextfield(
              myTextInputType: TextInputType.text, // Use TextInputType.text
              hintText: "Enter your Date of Birth",
              TextController: ParentSignUpCubit.get(context).birthdaytextcontroller, // Pass the controller here
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage(
                      'lib/appassets/images/DateCustemIcon.png'), // Path to your local image
                  width: 24, // Specify width
                  height: 24, // Specify height
                ),
              ),
              MyonTapFunc: () async {
                // Dismiss the keyboard
                FocusScope.of(context).requestFocus(FocusNode());

                // Show the date picker
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Color(0xFF25B9D3), //header and selected day background color
                          onPrimary: Colors.white, // titles and
                          onSurface: Color(0xFF133E87), // Month days, years
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                // If a date is selected, format and set the value in the field
                if (selectedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(selectedDate);
                  // Update the controller's text with the formatted date
                  ParentSignUpCubit.get(context).birthdaytextcontroller.text = formattedDate;
                }
              },
            ),
            const SizedBox(height: 20),
            Appformtextfield(
              TextController: ParentSignUpCubit.get(context).gendertextcontroller,
              hintText: "Enter your Gender",
              isDropdown: true,  // Set this to true for dropdown functionality
              dropdownItems: ['male', 'female'],  // Gender options
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage(
                      'lib/appassets/images/Vector.png'), // Path to your local image
                  width: 24, // Specify width
                  height: 24, // Specify height
                ),
              ),
              onChanged: (value) {
                
                if (value!=null)
                ParentSignUpCubit.get(context).gendertextcontroller.text=value;
              },
            ),
            const SizedBox(height: 20),
            Appformtextfield(
              hintText: "Enter your Address",
              TextController: ParentSignUpCubit.get(context).addresstextcontroller,
              isObscureText: true,
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage(
                      'lib/appassets/images/Address.png'), // Path to your local image
                  width: 24, // Specify width
                  height: 24, // Specify height
                ),
              ),
            ),
            const SizedBox(height: 16),
          
          ],
        ),
      ),
    );
  }
}
