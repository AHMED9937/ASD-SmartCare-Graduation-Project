import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/parent/chatbot/controllers/chatbot_state.dart';
import 'package:asdsmartcare/parent/chatbot/models/chat_message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  ChatBotCubit() : super(ChatBotInitial());
  static ChatBotCubit get(BuildContext context) => BlocProvider.of(context);

  late ChatResponse chatRes;
  bool speechEnabled = false;

  final TextEditingController questionController = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {'message': 'Hello, How can i help?', 'isUser': false},
  ];

  void sendMessage() {
    final text = questionController.text.trim();
    if (text.isEmpty) return;

    emit(ChatBotLoading());
    final token = CacheHelper.getData(key: 'token');

    Diohelper.postData(
          url: ApiConstants.ChatBotReasoning,
          token: token,
          data: {
            'messages': [
              {'content': text},
            ],
          },
        )
        .then((response) {
          chatRes = ChatResponse.fromJson(response.data);
          emit(ChatBotSuccess());
        })
        .catchError((error) {
          emit(ChatBotError());
        });
  }

  @override
  Future<void> close() {
    questionController.dispose();
    return super.close();
  }
}
