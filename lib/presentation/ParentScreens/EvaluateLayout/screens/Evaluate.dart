import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:flutter/material.dart';

class  Evaluate extends StatelessWidget {
  const  Evaluate({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        
        children: [

          Text(CacheHelper.getData(key: "token")),
        ],
      ),
    );
  }
}