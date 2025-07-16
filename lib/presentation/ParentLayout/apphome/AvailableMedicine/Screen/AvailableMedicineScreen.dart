import 'package:asdsmartcare/presentation/ParentScreens/apphome/AvailableMedicine/Controller/cubit/available_medicine_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/AvailableMedicine/Controller/cubit/available_medicine_state.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/AvailableMedicine/Screen/MedicenInfo.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Availablemedicinescreen extends StatelessWidget {
  const Availablemedicinescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AvailableMedicineCubit()..getAvailableMedicine(),
      child: BlocConsumer<AvailableMedicineCubit, AvailableMedicineState>(
        listener: (context, state) {
          // Listener for state changes
        },
        builder: (context, state) {
          AvailableMedicineCubit cubit = AvailableMedicineCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarWithText(context, "Available Medicine"),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Info Text at the top
                  Center(
                    child: const SizedBox(
                      width: 300,
                      child: Text(
                        'Search for medicine and pharmacy to find treatment',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Search Box
                  TextField(
                    onChanged: (value) => cubit.searchMedicine(value),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      hintText: "Try Search",
                      hintStyle: TextStyle(fontSize: 16),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),

                  // Medicine List or Loading Indicator
                  ConditionalBuilder(condition: state is !GetAvailableMedicineLoading, builder: (_)=> Expanded(child: MedicineList(cubit: cubit)), fallback: (context) =>  Expanded(child: Center(child: CircularProgressIndicator())),)
                   
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MedicineList extends StatelessWidget {
  const MedicineList({
    super.key,
    required this.cubit,
  });

  final AvailableMedicineCubit cubit;

  @override
  Widget build(BuildContext context) {
    return   ListView.builder(
                      itemCount: cubit.items.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          height: 180,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              margin: EdgeInsets.all(1),
                              shadowColor: Colors.grey,
                              elevation: 10,
                              surfaceTintColor: Colors.white,
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(33),
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            cubit.items[index].medicanName,
                                            style: const TextStyle(
                                              color: Color(0xFF133E87),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                             cubit.items[index].pharmacy.location,
                                            style: TextStyle(fontSize: 12),
                                            overflow: TextOverflow.clip,
                                            softWrap: true,
                                          ),
                                          // Text(
                                          //   "This charity have this medicine",
                                          //   style: TextStyle(
                                          //       color: Colors.green,
                                          //       fontSize: 12),
                                          //   overflow: TextOverflow.clip,
                                          //   softWrap: true,
                                          // ),
                                           AppButtons.containerTextButton(
                                            TextUtils.textHeader(
                                                "Medican’s Details",
                                                headerTextColor: Colors.white,
                                                fontSize: 11),
                                            () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MedicenInfo( medicen: cubit.items[index],),
                                                  ));
                                            },
                                            containerWidth: 127,
                                            containerHeight: 34,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      width: 112,
                                      height: 112,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(11),
                                      ),
                                      child: Image.network(cubit.items[index].medicanImage,fit:BoxFit.cover ,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                }
}
