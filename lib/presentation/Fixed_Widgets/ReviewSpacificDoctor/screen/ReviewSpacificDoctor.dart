import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';

/// Shows a rating dialog with star selector, optional comment, and a submit button.
Future<void> showRatingDialog(BuildContext context) async {
  int rating = 0;
  final TextEditingController commentController = TextEditingController();

  await showDialog(
    
    context: context,
    builder: (ctx) {
      return SizedBox(
        child: Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(33),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Rate this session',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF133E87),
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final filled = index < rating;
                        return IconButton(
                          icon: Icon(
                             Icons.star ,
                            color:filled? Color(0xFFFFC107):Color(0xFF959595),
                            size: 35,
                          ),
                          onPressed: () => setState(() {
                            rating = index + 1;
                          }),
                        );
                      }),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: commentController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Why you recommend this doctor (Optional)',
                        filled: true,
                        fillColor: Color(0xFF959595),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    AppButtons.containerTextButton(TextUtils.textHeader("Rate Now",headerTextColor: Colors.white),(){}),
                     ],
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
