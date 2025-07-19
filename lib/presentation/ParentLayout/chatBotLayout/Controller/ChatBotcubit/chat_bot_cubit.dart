import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/ParentLayout/chatBotLayout/Controller/ChatBotcubit/chat_bot_state.dart';
import 'package:asdsmartcare/presentation/ParentLayout/chatBotLayout/Model/ChatBotModel.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  ChatBotCubit() : super(ChatBotInitial());
  static ChatBotCubit get(context) => BlocProvider.of(context);

  late ChatResponse chatRes;
   bool speachEnable=false;


  TextEditingController ChatBotUserQustion=TextEditingController();
  List<Map<dynamic, dynamic>>AllSendAndRecivedMassge=[
    {
     "message":"Hello, How can i help?",
     "isUser":false,
    
    }
  ];
  void ChatBotSendMessage() {

    emit(ChatBotLoading());
    final token = CacheHelper.getData(key: "token");
    print(token);
    Diohelper.PostData(
      url: ApiConstants.ChatBotReasoning,
      token: token,
      data: {
        "messages" :[{ "content": ChatBotUserQustion.text}],       // corrected key
      },
    ).then((response) {
      chatRes=ChatResponse.fromJson(response.data);
      print(chatRes.response);
      emit(ChatBotSuccess());

    }).catchError((error) {
      emit(ChatBotError());
    });
  }



}
