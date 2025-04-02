import 'package:asdsmartcare/presentation/AfterLoginRootes/Doctor/cubit/doctors_list_cubit.dart';
import 'package:asdsmartcare/presentation/AfterLoginRootes/Doctor/cubit/doctors_list_state.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorsListCubit(),
      child: BlocConsumer<DoctorsListCubit, GetDoctorsListStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: TextUtils.textHeader("Doctors", fontSize: 20),
              centerTitle: true,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Expanded(
                  child: ListView.builder(
                    itemCount:DoctorsListCubit.get(context).myDoctorList.data.length,
                    itemBuilder: (context, index) {
                      final doctor = DoctorsListCubit.get(context).myDoctorList.data[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            tileColor: Color(0xFFE7EBF4),
                            contentPadding: EdgeInsets.all(10),
                            leading: Container(
                              // child: Image.asset(
                              //   doctor,
                              //   fit: BoxFit.fitHeight,
                              // ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              width: 50,
                              height: 66,
                            ),
                            title: Text(doctor.user!.userName,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextUtils.textDescription(doctor.specialization,
                                    fontSize: 10),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 10),
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 10),
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 10),
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 10),
                                    Icon(Icons.star_half,
                                        color: Colors.yellow, size: 10),
                                    SizedBox(width: 10),
                                    Text("(14 reviews)",
                                        style: TextStyle(color: Colors.blue)),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {

            DoctorsListCubit.get(context). SelectedDoctor=doctor;
            print(DoctorsListCubit.get(context). SelectedDoctor!.user!.userName);

                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                          color: Color(0xFF133E87),
                                          width: 9,
                                          height: 7,
                                          "lib/appassets/images/share.png"),
                                      TextUtils.textHeader("see details",
                                          headerTextColor: Color(0xFF133E87),
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
                                () {})),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
