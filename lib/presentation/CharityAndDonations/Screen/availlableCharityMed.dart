import 'package:asdsmartcare/presentation/CharityAndDonations/Model/CharityResponse.dart';
import 'package:asdsmartcare/presentation/CharityAndDonations/Screen/CharitiyMedicanInfo.dart';
import 'package:flutter/material.dart';
import 'package:asdsmartcare/presentation/ParentLayout/apphome/AvailableMedicine/Screen/MedicenInfo.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';

/// Displays a list of medicines passed in and allows local search filtering.
class AvaillableCharityMed extends StatefulWidget {
  final List<CharityMedicine> medicines;

  /// [medicines] is the data to display. No Cubit or API call.
  const AvaillableCharityMed({Key? key, required this.medicines}) : super(key: key);

  @override
  _AvaillableCharityMedState createState() => _AvaillableCharityMedState();
}

class _AvaillableCharityMedState extends State<AvaillableCharityMed> {
  late List<CharityMedicine> displayed;

  @override
  void initState() {
    super.initState();
    displayed = List.from(widget.medicines);
  }

  void _filter(String query) {
    setState(() {
      displayed = widget.medicines
          .where((med) => med.medicanName
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithText(context, 'Available Charity Medicine'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              width: 300,
              child: Text(
                'Try to Search for medicine name To find treatment',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              onChanged: _filter,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(12),
                hintText: 'Try Search',
                hintStyle: const TextStyle(fontSize: 16),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: displayed.length,
                itemBuilder: (context, index) {
                  final med = displayed[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(33),
                      ),
                      color: Colors.white,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    med.medicanName??"",
                                    style: const TextStyle(
                                      color: Color(0xFF133E87),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    med.pharmacy!.pLocation??"",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  AppButtons.containerTextButton(
                                    TextUtils.textHeader(
                                      'See Medicine Details',
                                      headerTextColor: Colors.white,
                                      fontSize: 11,
                                    ),
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Charitiymedicaninfo(medicen: med),
                                        ),
                                      );
                                    },
                                    containerWidth: 127,
                                    containerHeight: 34,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 112,
                              height: 112,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Image.network(
                                med.medicanImage??"",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
