import 'dart:ffi';

import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/Screen/AutismCheker.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/Screen/AutismTest.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/Screen/TestResult.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/controller/AddNewChildCubit/add_new_child_cubit_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/controller/AddNewChildCubit/add_new_child_cubit_state.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AiEvaluationScreen extends StatelessWidget {
  const AiEvaluationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNewChildCubit(),
      child: BlocConsumer<AddNewChildCubit, AddNewChildStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = AddNewChildCubit.get(context);

          return Scaffold(
            appBar: AppBarWithText(context, "Evaluate Tests"),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 255,
                    child: Column(
                      children: [
                        Center(
                            child: TextUtils.textDescription(
                                "What test you need?")),
                        Spacer(),
                        AppButtons.containerTextButton(
                            TextUtils.textHeader("Autism checker test",
                                headerTextColor: Colors.white), () {
                          {
                            TestType(context, cubit, true);
                          }
                        }),
                        AppButtons.containerTextButton(
                            TextUtils.textHeader("Autism level test",
                                headerTextColor: Colors.white), () {
                          TestType(context, cubit, false);
                        }),
                        Spacer(),
                        TextUtils.textHeader("Last autism test", fontSize: 20),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 365,
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) => Column(
                      children: [
                        if (CacheHelper.getData(key: "degree_prediction") !=
                            null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RecentTest(
                              isFirstTest: false,
                              BackToHomeButton: false,
                            ),
                          ),
                        if (CacheHelper.getData(key: "autism_prediction") != null)
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RecentTest(
                                isFirstTest: true,
                                BackToHomeButton: false,
                              )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void TestType(
      BuildContext context, AddNewChildCubit cubit, bool IsFirstTestType) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: TextUtils.textHeader("Choose Child for test"),
          content: SizedBox(
            height: 200,
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: cubit.children.length,
              itemBuilder: (context, index) {
                final isSelected = index == cubit.selectedIndex;
                return GestureDetector(
                  onTap: () => setState(() => cubit.selectedIndex = index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Color(0xFF133E87) // selected color
                            : Color(0xFFCCDFFF), // default color
                        borderRadius: BorderRadius.circular(23),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextUtils.textHeader(
                                    cubit.children[cubit.selectedIndex]
                                            ["name"] ??
                                        "ano",
                                    headerTextColor: Colors.white,
                                  ),
                                  TextUtils.textDescription(
                                    "8yo",
                                    disTextColor: Colors.white,
                                    fontSize: 15,
                                  ),
                                ],
                              ),
                              TextUtils.textDescription(
                                "Male",
                                disTextColor: Colors.white,
                                fontSize: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            AppButtons.containerTextButton(
                TextUtils.textHeader("Start the test now!",
                    headerTextColor: Colors.white), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IsFirstTestType
                        ? AutismTestScreen()
                        : AutismChekerScreen(),
                  ));
            }),
          ],
        ),
      ),
    );
  }
}
