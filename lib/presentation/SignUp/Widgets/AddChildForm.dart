import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/SignUp/cubit/Parentcubit/parent_sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddchildForm extends StatelessWidget {
  const AddchildForm({super.key});

  @override
  Widget build(BuildContext context) {
        final cubit = ParentSignUpCubit.get(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
          key: cubit.addParentFormKey
        ,
        child: SizedBox(
          width: 346,
          child: Column(
            children: [
               const SizedBox(height: 20),
              Appformtextfield(
               formValidator:  (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your child name';
                  }
                  return null;
                },
                //  TextController: ParentSignUpCubit.get(context).childNametextcontroller,
                hintText: "Enter your Child Name ",
                TextController:ParentSignUpCubit.get(context).ChildNametextcontroller ,
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage(
                        'lib/appassets/images/Vector.png'), // Path to your local image
                    width: 24, // Specify width
                    height: 24, // Specify height
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Appformtextfield(
                formValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your child Age ';
                  }if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Enter valid number';
                  }
                  return null;
                } ,
                //  TextController: ParentSignUpCubit.get(context).childNametextcontroller,
                hintText: "Enter your child Age ",
                TextController:ParentSignUpCubit.get(context).ChildAgetextcontroller ,
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
              DropdownButtonFormField(
                validator:(value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Child Gender ';
                  }  
                  return null;
                } ,
                focusColor: Colors.black,
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
                 
                 hintText: "Enter your Child Gender",
                 hintStyle: TextStyle(
                
                  color: Color.fromRGBO(62, 135, 107, 0.42),
                 ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        
                  ),
                  items: 
                  const[
                    DropdownMenuItem(
                      child: Text("Male"),
                      value: "male",
                    ), DropdownMenuItem(
                      child: Text("Female"),
                      value: "female",
                    ), 
                 
                  ],
                  onChanged: (val) {
                    if (val!=null)
                    ParentSignUpCubit.get(context).ChildGendertextcontroller.text=val;
      
                  }),
             
            ],
          ),
        ),
      ),
    );
  }
}