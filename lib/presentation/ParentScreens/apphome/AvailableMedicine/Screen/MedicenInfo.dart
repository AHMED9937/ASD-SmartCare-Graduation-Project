import 'package:flutter/material.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/AvailableMedicine/model/MedicinesResponse.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';

class MedicenInfo extends StatelessWidget {
  final MedicineData medicen;
  const MedicenInfo({super.key, required this.medicen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithText(context,"Medican" ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ——— Title ———
            Text(
              medicen.medicanName,
              style: TextStyle(  fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF133E87),),
            
            ),
            const SizedBox(height: 12),

            // ——— Description + Image Row ———
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                Expanded(
                  child: Text(
                    medicen.medicanInfo,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Medicine Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Image.network(
                    medicen.medicanImage,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 120,
                      height: 120,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 100),

            // ——— Available at ———
            Align(
              alignment: Alignment.center,
              child: Text(
                "Available at",
                style: TextStyle(  fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF133E87),),
              
              ),
            ),
            const SizedBox(height: 12),

            // ——— Pharmacy Tile(s) ———
            _buildPharmacyTile(
              name: medicen.pharmacy.name,
              location: medicen.pharmacy.location,
            ),

            // If you have more than one pharmacy, repeat or build a ListView.builder here...
          ],
        ),
      ),
    );
  }

  Widget _buildPharmacyTile({
    required String name,
    required String location,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF133E87),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          // you can swap this for a CircleAvatar if you like
          const Icon(Icons.local_pharmacy, size: 32, color: Colors.white),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                location,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
