

import 'package:flutter/material.dart';

class Sharedcomponents {


  void showToast({required String ContentText,required Color myColor })=> SnackBar(
                content: Text(ContentText),
                backgroundColor: myColor,
              );
}
//enum ToastStates{SUCCESS,ERRO,WARNING}