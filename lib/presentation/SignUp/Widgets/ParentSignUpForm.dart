import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/SignUp/cubit/Parentcubit/parent_sign_up_cubit.dart';
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
              hintText: "Enter your userName",
              TextController: ParentSignUpCubit.get(context).userNametextcontroller,
             
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
              hintText: "Enter your email",
              TextController: ParentSignUpCubit.get(context).emailtextcontroller,
            
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage(
                      'lib/appassets/images/mail.png'), // Path to your local image
                  width: 24, // Specify width
                  height: 24, // Specify height
                ),
              ),
            ),
          
            const SizedBox(height: 15),
              Appformtextfield(
              hintText: "Enter your phone Number",
              TextController: ParentSignUpCubit.get(context).phonetextcontroller,
             
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage(
                      'lib/appassets/images/phone.png'), // Path to your local image
                  width: 24, // Specify width
                  height: 24, // Specify height
                ),
              ),
            ),
           const SizedBox(height: 15),
             Appformtextfield(
              hintText: "Enter your  password",
              TextController: ParentSignUpCubit.get(context).passwordtextcontroller,
             
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage(
                      'lib/appassets/images/lock.png'), // Path to your local image
                  width: 24, // Specify width
                  height: 24, // Specify height
                ),
              ),
            ),
           
           const SizedBox(height: 15),
             Appformtextfield(
              hintText: " confirm Password",
              TextController: ParentSignUpCubit.get(context).confirmPasswordtextcontroller,
             
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage(
                      'lib/appassets/images/lock.png'), // Path to your local image
                  width: 24, // Specify width
                  height: 24, // Specify height
                ),
              ),
            ),
           
            const SizedBox(height: 15),
            Appformtextfield(
              hintText: "Enter your Age",
              TextController: ParentSignUpCubit.get(context).Agetextcontroller,
              
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
            const SizedBox(height: 15),
            Appformtextfield(
              hintText: "Enter your Address",
              TextController: ParentSignUpCubit.get(context).addresstextcontroller,
             
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
           
          
          ],
        ),
      ),
    );
  }
}
