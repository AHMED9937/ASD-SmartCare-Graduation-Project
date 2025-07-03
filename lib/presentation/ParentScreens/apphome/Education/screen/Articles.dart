import 'package:asdsmartcare/presentation/ParentScreens/apphome/Education/controller/cubit/education_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/Education/controller/cubit/education_state.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/Education/screen/ShowArticle.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/appImages.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Articles extends StatelessWidget {
  const Articles({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: AppButtons.arrowbutton(() => Navigator.pop(context)),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: LogoImage(60, 60),
        ),
      ),
      body: BlocProvider(
        create: (context) => AvailableEducationArticaleCubit()..getAvailableEducationArticale(),
        child: BlocConsumer<AvailableEducationArticaleCubit, AvailableEducationArticaleState>(
          listener: (context, state) 
          {
            // TODO: implement listener
          },
          builder: (context, state) {
          AvailableEducationArticaleCubit  cubit=AvailableEducationArticaleCubit.get(context);
            
            if (state is GetAvailableEducationArticaleLoading)
            return Center(child:CircularProgressIndicator() ,);
            if (state is GetAvailableEducationArticaleSuccess){
            return  Padding(
  padding: const EdgeInsets.all(15),
  child: ListView.builder(
    itemCount: cubit.items.length,
    itemBuilder: (context, index) {
      final item = cubit.items[index];
      return SizedBox(
        height: 200,
        child: Card(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 8),
          elevation: 10,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(33),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1) Fixed-size image on the left, clipped to match your design
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.image ?? '',
                    width: 85,
                    height: 85,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(width: 12),

                // 2) Main content column takes *all* leftover space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        item.title ?? '',
                        style: const TextStyle(
                          color: Color(0xFF133E87),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: 4),

                      // Info text, capped at 3 lines
                      Text(
                        item.info ?? '',
                        style: TextStyle(fontSize: 12),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Spacer(),

                      // 3) Bottom row: date/author on left, button on right
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "By Article creator\n2025-05-16",
                            style: TextStyle(fontSize: 11),
                          ),
                          AppButtons.containerTextButton(
                            TextUtils.textHeader(
                              "Read the article",
                              headerTextColor: Colors.white,
                              fontSize: 11,
                            ),
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Showarticle( 

                                    author:"" ,
                                    content: item.info??"",
                                    date: "",
                                    imageUrl: item.image??"",
                                    title: item.title??"",
                                  ),
                                ),
                              );
                            },
                            containerWidth: 127,
                            containerHeight: 34,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ),
);
}return SizedBox();
          },
        ),
      ),
    );
  }
}
