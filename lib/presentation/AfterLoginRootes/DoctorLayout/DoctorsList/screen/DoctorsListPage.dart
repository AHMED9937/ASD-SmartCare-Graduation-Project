import 'package:asdsmartcare/presentation/AfterLoginRootes/DoctorLayout/DoctorBooking/Screens/reservationScreen.dart';
import 'package:asdsmartcare/presentation/AfterLoginRootes/DoctorLayout/DoctorsList/cubit/doctors_list_cubit.dart';
import 'package:asdsmartcare/presentation/AfterLoginRootes/DoctorLayout/DoctorsList/cubit/doctors_list_state.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/appImages.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DoctorsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorsListCubit()..getDoctorsList(),
      child: BlocConsumer<DoctorsListCubit, GetDoctorsListStates>(
        listener: (context, state) {
          if (state is GetDoctorsListFailedStates) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to load doctors list")),
            );
          }
        },
        builder: (context, state) {
          final cubit = DoctorsListCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.white,
            
            appBar: AppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 80,
              elevation: 0,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Field
                TextField(
                  decoration: InputDecoration(
                    hintText: "Try search for doctor name...",
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Here are Doctors Near to you",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                // Content based on state
                Expanded(
                  child: state is GetDoctorsListLoadingStates
                      ? Center(child: CircularProgressIndicator())
                      : state is GetDoctorsListSuccsessStates
                          ? RefreshIndicator(
                              onRefresh: () async {
                                cubit.getDoctorsList();
                              },
                              child: ListView.builder(
                                itemCount: cubit.myDoctorList.data.length,
                                itemBuilder: (context, index) {
                                  final doctor = cubit.myDoctorList.data[index];
                                  return Card(
                                    shadowColor: Color(0xFF133E87),
                                    elevation: 5,
                                    margin: EdgeInsets.symmetric(vertical: 8.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      tileColor: Color(0xFFE7EBF4),
                                      contentPadding: EdgeInsets.all(10),
                                      leading: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        width: 50,
                                        height: 66,
                                        // Example: show image if available
                                        // child: doctor.user != null &&
                                        //         doctor.medicalLicense.isNotEmpty
                                        //     ? Image.network(
                                        //         doctor.medicalLicense,
                                        //         fit: BoxFit.cover,
                                        //       )
                                        //     : Icon(Icons.person),
                                      ),
                                      title: Text(
                                        doctor.user?.userName ?? "Unknown",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextUtils.textDescription(
                                              doctor.specialization,
                                              fontSize: 10),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              RatingBarIndicator(
                                                rating: doctor.ratingQuantity
                                                    .toDouble(),
                                                itemCount: 5,
                                                itemBuilder: (context, index) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemSize: 10,
                                                direction: Axis.horizontal,
                                              ),
                                              Text(
                                                  "(${doctor.ratingQuantity} reviews)",
                                                  style: TextStyle(
                                                      color: Colors.blue)),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              DoctorsListCubit.get(context)
                                                  .SelectedDoctor = doctor;
                                              print(
                                                  DoctorsListCubit.get(context)
                                                      .SelectedDoctor!
                                                      .user!
                                                      .userName);
                                            },
                                            child: Row(
                                              children: [
                                                // Image.asset(
                                                //   "lib/appassets/images/share.png",
                                                //   color: Color(0xFF133E87),
                                                //   width: 9,
                                                //   height: 7,
                                                // ),
                                                TextUtils.textDescription(
                                                    "Price start with ${doctor.sessionPrice ?? 0.0} EGP",
                                                    disTextColor:
                                                        Color(0xFF5B5B5B),
                                                    fontSize: 11),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: AppButtons.containerTextButton(
                                        containerHeight: 31,
                                        containerWidth: 85,
                                        containerBorderRadius:
                                            BorderRadius.circular(30),
                                        TextUtils.textDescription("Reserve",
                                            disTextColor: Colors.white),
                                        () {
                                         Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => Reservationscreen(myDoctor: doctor,),
             ));
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(child: Text("Something went wrong")),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
