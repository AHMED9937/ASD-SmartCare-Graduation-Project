// lib/presentation/AfterLoginRootes/apphome/autsiumTest/Screen/autism_test_screen.dart

import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/Screen/TestResult.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/controller/Test2/autism_cheker_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/controller/Test2/autism_cheker_state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';

class AutismChekerScreen extends StatelessWidget {
 
  const AutismChekerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Test2AutsiumCubit(),
      child: BlocConsumer<Test2AutsiumCubit, Test2AutsiumStates>(
        listener: (context, state) {
          final cubit = Test2AutsiumCubit.get(context);

          if (state is Test2GetOneQsPredicationSuccessState) {
            // automatically go to next question
            cubit.next();
          }

          if (state is Test2GetQsfinalPredicationSuccessState) {
            // on final prediction, navigate
            CacheHelper.SaveData(key: 'degree_prediction', value: "${state.degree_prediction}");
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) =>  Testresult(degreePrediction: state.degree_prediction.toString(),)),
              (_) => false,
            );
          }
          if (state is Test2GetQsfinalPredicationErrorState){
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text("The Answer Not Relevant"),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = Test2AutsiumCubit.get(context);
          final pages = cubit.buildQuestionWidgets();
          final idx = cubit.currentIndex;
          final total = pages.length;
          final progress = (idx + 1) / total;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              forceMaterialTransparency: true,
              backgroundColor: Colors.white,
              leading: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: AppButtons.arrowbutton(() => Navigator.pop(context)),
              ),
              centerTitle: true,
              toolbarHeight: 80,
              title: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Image.asset(
                  'lib/appassets/images/autismThink.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    TextUtils.textHeader("Autism Test", fontSize: 24),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.blue.shade100,
                      valueColor:
                          const AlwaysStoppedAnimation(Color(0xFF133E87)),
                      minHeight: 16,
                      borderRadius: BorderRadius.circular(23),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Question ${idx + 1} of $total',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 11),
                    Card(
                      elevation: 22,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 340,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: pages[idx],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ConditionalBuilder(condition: (state is! Test2GetQsfinalPredicationLoadingState)  , builder: (context) =>AppButtons.containerTextButton(
                      TextUtils.textHeader(
                        idx < total - 1 ? "Next Question" : "Finish Test",
                        headerTextColor: Colors.white,
                      ),
                      () {
                        cubit.reasonFinalPredictionForQs();
                      },
                    ) , fallback: (context) => CircularProgressIndicator(),),
                    const SizedBox(height: 8),
                    if (idx > 0)
                      AppButtons.containerTextButton(
                        TextUtils.textHeader(
                          "Previous Question",
                          headerTextColor: Colors.black,
                        ),
                        // invoke prev(), not just reference it
                        () {
                          cubit.prev();
                        },
                        containerColor: const Color(0xFF8FADE1),
                      ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
