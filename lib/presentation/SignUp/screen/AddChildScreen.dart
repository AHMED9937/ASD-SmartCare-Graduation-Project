import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/SignUp/Widgets/AddChildForm.dart';
import 'package:asdsmartcare/presentation/SignUp/cubit/Parentcubit/parent_sign_up_cubit.dart';
import 'package:asdsmartcare/presentation/SignUp/cubit/Parentcubit/parent_sign_up_state.dart';
import 'package:asdsmartcare/presentation/login/screen/SelectUserTypeScreen.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddChildScreen extends StatefulWidget {
  final String ParentId;
  const AddChildScreen({super.key, required this.ParentId});
  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ParentSignUpCubit(),
      child: BlocConsumer<ParentSignUpCubit, ParentSignUpState>(
        listener: (context, state) {
          if (state is AddChildSuccessState) {
            ParentSignUpCubit.get(context).ParentChilds.add(buildChildInfoCard(
                  age: ParentSignUpCubit.get(context)
                      .ChildAgetextcontroller
                      .text,
                  name: ParentSignUpCubit.get(context)
                      .ChildNametextcontroller
                      .text,
                  gender: ParentSignUpCubit.get(context)
                      .ChildGendertextcontroller
                      .text,
                ));
          } else if (state is AddChildErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("")));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: AppButtons.arrowbutton(() => Navigator.pop(context)),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 14),
                      TextUtils.textHeader(
                        "Sign up",
                        fontSize: 36,
                        myfontFamily: 'Roboto',
                      ),
                      TextUtils.textDescription(
                        "Create an account to use our service.",
                        myfontFamily: 'Roboto',
                        fontSize: 12,
                      ),
                      const SizedBox(height: 40),
                      if (ParentSignUpCubit.get(context).ParentChilds.length !=
                          0)
                        SizedBox(
                          height: 100,
                          width: 350,
                          child: ListView.builder(
                            itemCount: ParentSignUpCubit.get(context)
                                .ParentChilds
                                .length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ParentSignUpCubit.get(context)
                                      .ParentChilds[index],
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      // <— corrected widget name
                      AddchildForm(),

                      const SizedBox(height: 47),
                        ConditionalBuilder(
                        condition: state is! AddChildLoadingState,
                        builder: (context) =>AppButtons.containerTextButton(
                        containerColor: Color(0xFFCCCDFFF),
                        TextUtils.textHeader(
                          "Add Child ",
                          headerTextColor: Color(0xFF133E87),
                          myfontFamily: "Roboto",
                          fontSize: 20,
                        ),
                        () {
                          if ( ParentSignUpCubit.get(context)
                              .addParentFormKey
                              .currentState!
                              .validate()) {
                           ParentSignUpCubit.get(context)
                              .addChild(parentId: widget.ParentId);
                          }
                        
                        },
                      ),
                       fallback: (_) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                     AppButtons.containerTextButton(
                          TextUtils.textHeader(
                            "Next Step",
                            headerTextColor: Colors.white,
                            myfontFamily: "Roboto",
                            fontSize: 20,
                          ),
                          () 
                          {
      
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => Loginscreen()),
  (Route<dynamic> route) => false,
);
        
                          },
                        ),
                       
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildChildInfoCard({
  required String name,
  required String gender,
  required String age,
}) {
  final bool isMale = gender.toLowerCase() == 'male';
  final Color bgColor =
      isMale ? const Color(0xFF133E87) : const Color(0xFFCCDFFF);
  final Color textColor = isMale ? Colors.white : const Color(0xFF133E87);

  return Container(
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(23),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name and age row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUtils.textHeader(
                  name,
                  headerTextColor: textColor,
                ),
                TextUtils.textDescription(
                  '${age}yo',
                  disTextColor: textColor,
                  fontSize: 15,
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Gender row
            Row(
              children: [
                TextUtils.textDescription(
                  gender,
                  disTextColor: textColor,
                  fontSize: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
