import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/Screens/reservationScreen.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorsList/cubit/doctors_list_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorsList/cubit/doctors_list_state.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorsList/model/GetDoctorsListModel.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/AvailableMedicine/Screen/AvailableMedicineScreen.dart';
import 'package:asdsmartcare/presentation/CharityAndDonations/Screen/CharityMedicine.dart';
import 'package:asdsmartcare/presentation/Doctor/Home/DoctorHomeScreen.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/Education/screen/Articles.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/Screen/AiEvaluation.dart';
import 'package:asdsmartcare/presentation/ParentScreens/chatBotLayout/screen/chatScreen.dart';
import 'package:asdsmartcare/presentation/ParentScreens/progressLayout/screens/progress.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/appImages.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: const CurvedDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 80,
          scrolledUnderElevation: 0.0,
          shadowColor: Colors.white,
          centerTitle: true,
          title: LogoImage(60, 60),
          actions: [
            Icon(
              Icons.notifications, //color: Color(0xFF133E87)
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 1,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildServiceItem("lib/appassets/images/autism.png",
                    "Ai Evaluation", context, AiEvaluationScreen()),
                _buildServiceItem("lib/appassets/images/child_progress.png",
                    "Child progress", context, ChildProgressScreen()),
                _buildServiceItem("lib/appassets/images/education.png",
                    "Educational ", context, Articles()),
                _buildServiceItem("lib/appassets/images/chatbot.png",
                    "Chat bot Help", context, ChatBotscreen()),
                _buildServiceItem("lib/appassets/images/medical.png",
                    "Medical ", context, Availablemedicinescreen()),
                _buildServiceItem("lib/appassets/images/charity.png",
                    " charities", context, CharityMedicine()),
              ],
            ),
            SizedBox(height: 9),
            TextUtils.textHeader("Recommended Doctors",
                fontSize: 19, headerTextColor: Color(0xFF082F71)),
            TextUtils.textDescription(
                "We connect you with the best therapists in every department!",
                fontSize: 10,
                disTextColor: Color(0xFF082F71)),
            Expanded(flex: 1, child: RecomededDoctorWidget()),
          ],
        ));
  }

  Widget _buildServiceItem(
      String iconPath, String title, BuildContext context, Widget Navigate_to) {
    return GestureDetector(
      onTap: () {
        NavgatTO(context, Navigate_to);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          shadowColor: Color(0xFF133E87),
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconPath,
                  height: 52,
                  width: 52,
                ),
                SizedBox(height: 5),
                Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecomededDoctorWidget extends StatelessWidget {
  const RecomededDoctorWidget({Key? key}) : super(key: key);

  Widget Specialist(Doctor doctor, BuildContext context) {
    return Card(
      shadowColor: const Color(0xFF133E87),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(23),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: 220,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                ),
                child: doctor.image != null
                    ? Image.network(
                        doctor.image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        alignment: Alignment.topCenter,
                      )
                    : Container(
                        color: Colors.grey,
                        width: double.infinity,
                      ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextUtils.textHeader(
                    doctor.parent?.userName ?? '',
                    headerTextColor: const Color(0xFF00225C),
                    fontSize: 12,
                  ),
                 
                  Container(
                    width: 48,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00225C),
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        TextUtils.textDescription(
                          '${doctor.ratingsAverage??0}.0',
                          disTextColor: Colors.white,
                          fontSize: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
           
            const SizedBox(height: 8),
            Center(
              child: AppButtons.containerTextButton(
                TextUtils.textHeader(
                  'Book Now!',
                  headerTextColor: Colors.white,
                  fontSize: 14,
                ),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Reservationscreen(myDoctor: doctor),
                    ),
                  );
                },
                containerHeight: 32,
                containerWidth: 120,
                containerColor: const Color(0xFF133E87),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorsListCubit()..getDoctorsList(RecomededDoctor: true),
      child: BlocConsumer<DoctorsListCubit, GetDoctorsListStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final docs = DoctorsListCubit.get(context).myDoctorList;
          if (state is GetDoctorsListLoadingStates) {
            return const SizedBox(
              height: 300,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is GetDoctorsListSuccsessStates) {
            return SizedBox(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // control size by flex values: change cardFlex to adjust width
                  const int cardFlex = 6;
                  const int totalFlex = 10;
                  final cardWidth = constraints.maxWidth * cardFlex / totalFlex;

                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: docs.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: cardWidth,
                        child: Specialist(docs[index], context),
                      );
                    },
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class CurvedDrawer extends StatelessWidget {
  const CurvedDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFD9D9D9),
      child: Container(
        child: Column(
          children: [
            // ---- Header with curved bottom-right corner ----
            SizedBox(
              width: double.infinity,
              height: 270,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF315899), // your blue
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(333),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // // profile pic
                    // const CircleAvatar(
                    //   radius: 32,
                    //   backgroundImage: NetworkImage(
                    //     'https://i.pravatar.cc/150?img=5',
                    //     // replace with your image
                    //   ),
                    // ),
                    // Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 15.0, horizontal: 10),
                    //     child: TextUtils.textDescription("Nermeen Ahmed",
                    //         disTextColor: Colors.white)),
                  ],
                ),
              ),
            ),

            // ---- Menu items ----
            Expanded(
              child: ListView(
                children: [
                  _buildTile(Icons.home, 'Home', () {}),
                  _buildTile(Icons.person_outline, 'Profile', () {/*..*/}),
                  _buildTile(Icons.notifications_none, 'Notifications', () {
                    /*..*/
                  }),
                  _buildTile(Icons.settings, 'Settings', () {/*..*/}),
                ],
              ),
            ),

            // ---- Logout at the bottom ----
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFF315899)),
              title: const Text(
                'Logout',
                style: TextStyle(color: Color(0xFF315899)),
              ),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Loginscreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[800]),
      title: Text(
        title,
        style: TextStyle(color: Colors.grey[800]),
      ),
      onTap: onTap,
    );
  }
}
