import 'package:asdsmartcare/presentation/DoctorLayout/DoctorProfile/Screen/editDoctorProfile.dart';
import 'package:asdsmartcare/presentation/DoctorLayout/DoctorProfile/Screen/viewPdf.dart';
import 'package:asdsmartcare/presentation/DoctorLayout/DoctorProfile/cubit/doctor_profile_data_cubit.dart';
import 'package:asdsmartcare/presentation/DoctorLayout/DoctorProfile/cubit/doctor_profile_data_state.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/DoctorBooking/cubit/Booking/booking_state.dart';
import 'package:asdsmartcare/presentation/ParentLayout/profileLayout/screen/ChangePasswordScreen.dart';
import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/model/GetAllSession.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({Key? key}) : super(key: key);

  Widget _buildTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Color(0XFF133E87)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
    );
  }

  // new PDF tile
  Widget _buildPdfTile(BuildContext context, String lincice) {
    return ListTile(
      leading: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
      title: Text("Medical License"),
      subtitle: const Text('Tap to view PDF'),
      trailing: const Icon(Icons.open_in_new, size: 18),
      onTap: () => NavgatTO(context, FileFetchAndOpenScreen(rawUrl: lincice)),
    );
  }

  Future<void> _openPdf(BuildContext context, medicalLicensePdfUrl) async {
    final uri = Uri.parse(medicalLicensePdfUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open PDF.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => GetDoctorDataCubit()..getDoctorData(),
      child: BlocConsumer<GetDoctorDataCubit, GetDoctorDataStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          GetDoctorDataCubit cubit = GetDoctorDataCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey[100],
            body: ConditionalBuilder(
              condition: state is! GetDoctorDataLoadingStates,
              fallback: (_) => Center(
                child: CircularProgressIndicator(),
              ),
              builder: (_) => SingleChildScrollView(
                child: Column(
                  children: [
                    // inside your build():

                    Container(
                      height: size.height * 0.32,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // 1) Gradient header background
                          Container(
                            height: size.height * 0.25,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [ Colors.white,Color(0xFF133E87)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(32),
                                bottomRight: Radius.circular(32),
                              ),
                            ),
                          ),

                          // 2) Back button
                          

                          // 3) Avatar overlapping the header
                          Positioned(
                            top: size.height * 0.25 - 66,
                            left: (size.width / 2) - 66,
                            child: Container(
                              width: 132,
                              height: 132,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white10,
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                image: DecorationImage(
                                  alignment: Alignment.topCenter,
                                  image: NetworkImage(
                                      cubit.Cur_Doctor!.data!.image??""),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          // 4) Name, specialty & rating below the avatar
                          Positioned(
                            top: size.height * 0.25 +
                                72, // avatar top + radius + spacing
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Text(
                                  '${cubit.Cur_Doctor!.data!.parent!.userName}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  cubit.Cur_Doctor!.data!.speciailization ?? '',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Row of stars based on average rating
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(

                                    cubit.Cur_Doctor!.data!.ratingsAverage ?? 0,
                                    (_) => const Icon(Icons.star,
                                        color: Colors.amber, size: 20),
                                  ),
                                ),
                             
                             
                              ],
                           
                           
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 85),

                   
                    const SizedBox(height: 24),

                    // ===== Info Card =====
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            children: [
                              _buildTile(
                                  Icons.person,
                                  'Name',
                                  cubit.Cur_Doctor!.data!.parent!.userName ??
                                      ""),
                              const Divider(),
                              _buildTile(
                                  Icons.business,
                                  'Department',
                                  cubit.Cur_Doctor!.data!.speciailization ??
                                      ""),
                              const Divider(),
                              _buildTile(
                                  Icons.workspace_premium,
                                  'qualifications',
                                  cubit.Cur_Doctor!.data!.qualifications ?? ""),
                              const Divider(),
                              _buildTile(Icons.attach_money, 'Session Price',
                                  "${cubit.Cur_Doctor!.data!.sessionPrice.toString() ?? ""}"),

                              const Divider(),
                              _buildTile(Icons.email, 'Email Address',
                                  cubit.Cur_Doctor!.data!.parent!.email ?? ""),
                              const Divider(),
                              // _buildTile(Icons.phone, 'Phone Number', ""),

                              const Divider(),
                              _buildTile(Icons.cake, 'Age',
                                  "${cubit.Cur_Doctor!.data!.parent!.age ?? ""}"),
                              const Divider(),

                              // ←–– our new PDF field here ––→
                              _buildPdfTile(context,
                                  cubit.Cur_Doctor!.data!.medicalLicense!),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ===== Action Buttons =====
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.edit,
                                  color: Color(0XFFCCDFFF)),
                              label: TextUtils.textHeader("Edit Profile",
                                  headerTextColor: Colors.white),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0XFF133E87),
                                shape: const StadiumBorder(),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: ()=>NavgatTO(context, EditDoctorProfileScreen(DoctorD: cubit.Cur_Doctor!)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              icon: const Icon(
                                Icons.lock_outline,
                                color: Color(0XFF133E87),
                              ),
                              label: const Text(
                                'Change Password',
                                style: TextStyle(color: Color(0XFF133E87)),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: const StadiumBorder(),
                                side:
                                    const BorderSide(color: Color(0XFF133E87)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () =>NavgatTO(context, ChangePasswordScreen(isParent:false)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                                shape: const StadiumBorder(),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () =>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Loginscreen(),),(route) => false,),
                              child: const Text('Log Out'),
                            ),
                          ),
                        ],
                      ),
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
