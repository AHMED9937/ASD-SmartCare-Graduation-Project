import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/Screens/reservationScreen.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorsList/cubit/doctors_list_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorsList/cubit/doctors_list_state.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorsList/model/GetDoctorsListModel.dart';
import 'package:asdsmartcare/presentation/SignUp/Model/SignupresDoctorModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DoctorsListPage extends StatelessWidget {
  const DoctorsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorsListCubit()..getDoctorsList(),
      child: BlocConsumer<DoctorsListCubit, GetDoctorsListStates>(
        listener: (ctx, state) {
          if (state is GetDoctorsListFailedStates) {
            ScaffoldMessenger.of(ctx).showSnackBar(
              const SnackBar(content: Text("Failed to load doctors list")),
            );
          }
        },
        builder: (ctx, state) {
          final cubit = DoctorsListCubit.get(ctx);

          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                // 1) Header
                Container(
                  height: 90,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                   
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(32),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Find Your Doctor",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // 2) Search bar (overlapping)
                Transform.translate(
                  offset: const Offset(0, -40),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: TextField(
                        onChanged: (q) => cubit.SearchDoctorsList(ByName: q),
                        decoration: const InputDecoration(
                            hintText: "Search by specialization or area…",
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15)),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 3) Section title
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Available Doctors",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333444),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // 4) List
                Expanded(
                  child: state is GetDoctorsListLoadingStates
                      ? const Center(child: CircularProgressIndicator())
                      : state is GetDoctorsListSuccsessStates
                          ? ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              itemCount: cubit.myDoctorList.length,
                              itemBuilder: (ctx, i) {
                                final d = cubit.myDoctorList[i];
                                return _buildDoctorCard(ctx, d);
                              },
                            )
                          : const Center(child: Text("Something went wrong")),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDoctorCard(BuildContext context, Doctor d) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => Reservationscreen(myDoctor: d)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Photo
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: d.image != null
                  ? Image.network(d.image!,height:200 , width: double.maxFinite, fit: BoxFit.contain,alignment: Alignment.topCenter,)
                  : Container(
                      height: 160,
                      color: Colors.grey[200],
                      child: const Icon(Icons.person,
                          size: 60, color: Colors.grey),
                    ),
            ),

            // Info & button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    d.parent?.userName ?? "Unknown",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    d.specialization ?? "General Practitioner",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      RatingBarIndicator(
                        // if ratingsAverage is null, treat it as 0
                        rating: (d.ratingsAverage ?? 0).toDouble(),
                        itemCount: 5,
                        itemSize: 16.0,
                        direction: Axis.horizontal,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "${d.ratingQuantity} reviews",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.blue),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.attach_money_outlined, size: 16),
                          const SizedBox(width: 2),
                          Text(
                            "${d.sessionPrice?.toStringAsFixed(0) ?? '0'} EGP",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF133E87),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Reservationscreen(myDoctor: d)),
                      ),
                      child: const Text(
                        "Reserve",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
