import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/Screens/reservationScreen.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorsList/cubit/doctors_list_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorsList/cubit/doctors_list_state.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorsList/model/GetDoctorsListModel.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/AvailableMedicine/Screen/AvailableMedicineScreen.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/CharityAndDonations/Screen/CharityMedicine.dart';
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

    return  Scaffold(
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
            body: BlocProvider(
              create: (context) => DoctorsListCubit()..getDoctorsList(RecomededDoctor: true),
              child: BlocConsumer<DoctorsListCubit, GetDoctorsListStates>(
                listener: (context, state) {
               
                },
                builder: (context, state) {
                    
                

               
                  
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Welcome ",
                                style: TextStyle(
                                    color: Color(0xFF133E87), fontSize: 18)),
                            Text("Ahmed,",
                                style: TextStyle(
                                    color: Color(0xFF90AED4),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 10),SizedBox(height: 8),
                       
                        SizedBox(height: 8),
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            _buildServiceItem("lib/appassets/images/autism.png",
                                "Ai Evaluation", context, AiEvaluationScreen()),
                            _buildServiceItem(
                                "lib/appassets/images/child_progress.png",
                                "Child progress",
                                context,
                                ChildProgressScreen()),
                            _buildServiceItem(
                                "lib/appassets/images/education.png",
                                "Educational ",
                                context,
                                Articles()),
                            _buildServiceItem(
                                "lib/appassets/images/chatbot.png",
                                "Chat bot Help",
                                context,
                                ChatBotscreen()),
                            _buildServiceItem(
                                "lib/appassets/images/medical.png",
                                "Medical ",
                                context,
                                Availablemedicinescreen()),
                            _buildServiceItem(
                                "lib/appassets/images/charity.png",
                                " charities",
                                context,
                                CharityMedicine()),
                          ],
                        ),
                        SizedBox(height: 9),
                        TextUtils.textHeader("Recommended Doctors",
                            fontSize: 20, headerTextColor: Color(0xFF082F71)),
                        TextUtils.textDescription(
                            "We connect you with the best therapists in every department!",
                            fontSize: 10,
                            disTextColor: Color(0xFF082F71)),
                        ConditionalBuilder(condition: state is !GetDoctorsListLoadingStates, builder: (_)=>SizedBox(
                          width: 500,
                          height: 350,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:  DoctorsListCubit.get(context).myDoctorList.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                children: [
                                  Specialist( DoctorsListCubit.get(context).myDoctorList[index],context),
                                  SizedBox(width: 24),

                                  // You can add more specialist containers here
                                ],
                              ),
                            ),
                          ),
                        ),
                       fallback: (_)=>Center(child:CircularProgressIndicator() ,)),
                        
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ;
  }

  Widget Specialist(Doctor doctor,BuildContext context){

    return Card(
      shadowColor: Color(0xFF133E87),
      elevation: 10,
      child: Container(
        width: 220, // increased width
        height: 280, // increased height
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(23),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          
          children: [
            Expanded(
              child: Container(
                width: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                  ),
                ),
                // Optionally show an image here:
                
                child: doctor.image!=null? Image.network(
                  doctor.image!,
                ):Container(decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(22),topRight: Radius.circular(22) )),),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextUtils.textHeader(
                        doctor.parent!.userName??"",
                        headerTextColor: Color(0xFF00225C),
                        fontSize: 14,
                      ),
                      TextUtils.textDescription(
                        doctor.specialization??"",
                        fontSize: 10,
                      ),
                    ],
                  ),
                  Container(
                    width: 46,
                    height: 22,
                    decoration: BoxDecoration(
                      color: Color(0xFF00225C),
                      borderRadius: BorderRadius.all(Radius.circular(36)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [Color(0xFFFFC80B), Color(0xFFE89318)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds);
                          },
                          child: Icon(
                            Icons.star,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                        TextUtils.textDescription("${doctor.ratingQuantity}.0",
                            disTextColor: Colors.white, fontSize: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: AppButtons.containerTextButton(
                TextUtils.textHeader(
                  "Book Now!",
                  headerTextColor: Colors.white,
                ),
                () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Reservationscreen(myDoctor: doctor),));
                },
                containerHeight: 30,
                containerWidth: 128,
                containerColor: Color(0xFF133E87),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
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
