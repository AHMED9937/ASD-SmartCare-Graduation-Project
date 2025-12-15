import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/features/chatbot/controllers/chat_bot_state.dart';
import 'package:asdsmartcare/features/chatbot/models/ChatBotModel.dart';
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
    Diohelper.postData(
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








