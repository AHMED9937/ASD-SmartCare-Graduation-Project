import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:flutter/material.dart';

class  Progress extends StatelessWidget {
  const  Progress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        
        children: [

          Text(CacheHelper.getData(key: "login")),
        ],
      ),
    );
  }
}