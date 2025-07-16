import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/Screen/AutismCheker.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/Screen/AutismTest.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/Screen/TestResult.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/controller/GetChildTestResults/cubit/test_history_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/controller/GetChildTestResults/cubit/test_history_state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiEvaluationScreen extends StatelessWidget {
  const AiEvaluationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TestHistoryCubit()
        ..GetAutismLevelTestHistory()
        ..GetAutismTestHistory(),
      child: BlocConsumer<TestHistoryCubit, GetTestHistoryStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = TestHistoryCubit.get(context);

          // Safely retrieve the first test outputs (if any)
          final autismHistory = cubit.His_autisumTest?.data;
          final levelHistory = cubit.His_autisumLevelTest?.data;

          final String? autismPredictionHis =
              (autismHistory != null && autismHistory.isNotEmpty)
                  ? autismHistory.first.output?.autismPrediction.toString()
                  : null;
          final String? degreePrediction =
              (levelHistory != null && levelHistory.isNotEmpty)
                  ? levelHistory.first.output?.degreePrediction.toString()
                  : null;

          return Scaffold(
            appBar: AppBarWithText(context, "Evaluate Tests"),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 12),
              child: ConditionalBuilder(
                condition: state is !GetAutisumLevelTestHistoryLoadingStates,
                fallback: (_)=>Center(child: CircularProgressIndicator(),),
                builder:(_)=> Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextUtils.textDescription(
                      "Choose the test you need", 
                      fontSize: 14,
                      disTextColor: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => _navigateToTest(context, false),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.search,
                                      size: 32,
                                      color: Color(0xFF133E87),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "Autism Checker",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF133E87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => _navigateToTest(context, true),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.bar_chart,
                                      size: 32,
                                      color: Color(0xFF133E87),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "Autism Level",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF133E87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextUtils.textHeader("Recent Tests", fontSize: 20),
                    const SizedBox(height: 12),
                    if (autismPredictionHis != null)
                      Card(
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          title: const Text("Checker Test Result"),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Testresult(
                                autismPrediction: autismPredictionHis,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (degreePrediction != null)
                      Card(
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: const Icon(
                            Icons.assessment,
                            color: Colors.blue,
                          ),
                          title: const Text("Level Test Result"),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Testresult(
                                degreePrediction: degreePrediction,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (autismPredictionHis == null && degreePrediction == null)
                      Center(
                        child: TextUtils.textDescription(
                          "No tests run yet. Tap above to start.",
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToTest(BuildContext context, bool isFirstTest) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => isFirstTest
            ? const AutismChekerScreen()
            : const AutismTestScreen(),
      ),
    );
  }
}
