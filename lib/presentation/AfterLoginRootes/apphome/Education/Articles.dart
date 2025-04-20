import 'package:asdsmartcare/presentation/AfterLoginRootes/apphome/Education/ShowArticle.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/appImages.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';

class Articles extends StatelessWidget {
  const Articles({super.key});

  @override
  Widget build(BuildContext context) {
    List items = ["Article’s Title ","Article’s Title ","Article’s Title ","Article’s Title ",];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        
  backgroundColor: Colors.white,
  leading: Padding(
    padding: const EdgeInsets.only(top: 30), 
    child: AppButtons.arrowbutton(() => Navigator.pop(context)),
  ),
  centerTitle: true,
  toolbarHeight: 80,
  title: Padding(
    padding: const EdgeInsets.only(top: 30),
    child:LogoImage(60,60),
  ),
),

      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  margin: EdgeInsets.all(1),
                  shadowColor: Colors.grey,
                  elevation:10 ,
                  surfaceTintColor: Colors.white,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(33),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                items[index],
                                style: const TextStyle(
                                  color: Color(0xFF133E87),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet consectetur , mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus..",
                                style: TextStyle(fontSize: 12),
                                overflow: TextOverflow.clip,
                                softWrap: true,
                              ),
                              AppButtons.containerTextButton(
                                
                                TextUtils.textHeader("Read the article", headerTextColor: Colors.white,fontSize: 11),
                                () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => Showarticle(),));
                                },
                                containerWidth: 127,
                                containerHeight: 34,
                              ),
                            ],
                          ),
                        ),
                          SizedBox(width: 10),
                           Column(
                             children: [
                               Container(
                                                       decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                                       ),
                                                       width: 85,
                                                       height: 85,
                                                     ),
                             Spacer(),
                             Text("By Article creator\n2024, 10, 25",
                             style:
                             TextStyle(fontSize: 11),
                            ),
                             ],
                           ),
                     
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
