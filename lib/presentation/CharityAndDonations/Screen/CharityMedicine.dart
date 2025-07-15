import 'package:asdsmartcare/presentation/CharityAndDonations/Controller/cubit/charity_cubit.dart';
import 'package:asdsmartcare/presentation/CharityAndDonations/Controller/cubit/charity_state.dart';
import 'package:asdsmartcare/presentation/CharityAndDonations/Screen/CharityInfo.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharityMedicine extends StatelessWidget {
  const CharityMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AvailableCharityCubit()..getAvailableCharity(),
      child: BlocConsumer<AvailableCharityCubit, AvailableCharityState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = AvailableCharityCubit.get(context);
          final items = cubit.items ?? [];

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarWithText(context, "Charity Support"),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 300,
                        child: const Text(
                          'Autism progress is growth in skills and behavior',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    TextField(
                      onChanged: (value) {
                        cubit.searchCharity(value);
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(1),
                        hintText: " Search with Address",
                        hintStyle: const TextStyle(fontSize: 16),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Show list or loading indicator and let the outer scroll view handle scrolling
                    if (state is GetAvailableCharityLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (state is GetAvailableCharitySuccess)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final charity = items[index];
                          return Container(
                            width: double.infinity,
                            height: 190,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                margin: const EdgeInsets.all(1),
                                shadowColor: Colors.grey,
                                elevation: 10,
                                surfaceTintColor: Colors.white,
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              charity.charityName ?? '',
                                              style: const TextStyle(
                                                color: Color(0xFF133E87),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              charity.charityAddress ?? '',
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              overflow: TextOverflow.clip,
                                              softWrap: true,
                                            ),
                                            Text(
                                              charity.charityMedican
                                                      ?.map((action) =>
                                                          (action.medicanName ??
                                                              []))
                                                      .join(', ') ??
                                                  '',
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 12),
                                              overflow: TextOverflow.clip,
                                              softWrap: true,
                                            ),
                                            AppButtons.containerTextButton(
                                              TextUtils.textHeader(
                                                  "Charity Details",
                                                  headerTextColor:
                                                      Colors.white,
                                                  fontSize: 11),
                                              () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CharityInfo(
                                                      charityData: charity,
                                                    ),
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
                                          borderRadius:
                                              BorderRadius.circular(11),
                                        ),
                                        child: Image.network(
                                            charity.logo ?? ''),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    else
                      const Center(
                        child: Text('No charities found'),
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
}
