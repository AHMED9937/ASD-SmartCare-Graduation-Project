import 'package:asdsmartcare/presentation/ParentScreens/chatBotLayout/Controller/ChatBotcubit/chat_bot_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/chatBotLayout/Controller/ChatBotcubit/chat_bot_state.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBotscreen extends StatefulWidget {
  const ChatBotscreen({Key? key}) : super(key: key);

  @override
  _ChatBotscreenState createState() => _ChatBotscreenState();
}

class _ChatBotscreenState extends State<ChatBotscreen> {
  final _scrollController = ScrollController();
  // 1) Own your cubit instance here:
  final ChatBotCubit cubit = ChatBotCubit();

  @override
 

  @override
  void dispose() {
    _scrollController.dispose();
    cubit.close(); // always close your cubit
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(bool isLoading) {
    final text = cubit.ChatBotUserQustion.text.trim();
    if (text.isEmpty || isLoading) return;

    cubit.AllSendAndRecivedMassge.add({
      'message': text,
      'isUser': true,
    });
    cubit.ChatBotSendMessage();
    cubit.ChatBotUserQustion.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      // 3) Inject the same instance you own:
      value: cubit,
      child: BlocConsumer<ChatBotCubit, ChatBotState>(
        listener: (context, state) {
        if (state is ChatBotSuccess) {
            cubit.AllSendAndRecivedMassge.add(
            {
              "message": cubit.chatRes.response,
              "isUser": false,
            });
          }
        if (state is ChatBotError) 
        {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text("Error, please try again."),
              ),
            );
          }
          _scrollToBottom();
        },
        builder: (context, state) {

        final messages = cubit.AllSendAndRecivedMassge;
        final isLoading = state is ChatBotLoading;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: AppButtons.arrowbutton(() => Navigator.pop(context)),
              ),
              toolbarHeight: 80,
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextUtils.textHeader(
                  "Chatbot",
                  headerTextColor: const Color(0xFF133E87),
                  fontSize: 23,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Image.asset("lib/appassets/images/chatBotRobot.png"),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children:
                [


                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextUtils.textDescription(
                      "A chatbot is an AI that assists through conversation.",
                      fontSize: 17,
                      disTextColor: const Color(0xFF133E87),
                    ),
                  ),


                  Expanded(

                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length + (isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < messages.length) {
                          final msg = messages[index];
                          final isUser = msg['isUser'] as bool;
                          final text = msg['message'] as String;
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: isUser
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                if (!isUser)
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: 8.0),
                                    child: Image.asset(
                                      "lib/appassets/images/chatBotRobot.png",
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                Flexible(
                                  child: ChatBubble(
                                    isUser: isUser,
                                    text: text,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        // bot “thinking” bubble
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Image.asset(
                                  "lib/appassets/images/chatBotRobot.png",
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFCCDFFF),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child:
                                    TextUtils.textHeader("reasoning..."),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ConditionalBuilder(
                      condition: !isLoading,
                      fallback: null,
                      builder:(context) =>  TextField(
                        onSubmitted: (_) => _sendMessage(isLoading),

                        controller: cubit.ChatBotUserQustion,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          hintText: 'Write your question here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
                          // prefixIcon: IconButton(
                          //   icon:  cubit.speachEnable? Icon(Icons.keyboard_voice_outlined):Icon(Icons.square),
                          //   onPressed: cubit.speachEnable
                          //       ? () => cubit.speechToText.listen(
                          //             onResult: (result) => setState(() {
                          //               cubit.ChatBotUserQustion.text =
                          //                   result.recognizedWords;
                          //             }),
                          //           )
                          //       : null,
                          // ),
                          suffixIcon:IconButton(
                                  icon: const Icon(Icons.send),
                                  color: Colors.grey,
                                  onPressed: () => _sendMessage(isLoading),
                                ),
                          suffixIconConstraints:
                              const BoxConstraints(minWidth: 48, minHeight: 48),
                        ),
                      ),
                    ),
                  ),
                

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isUser;
  final String text;

  const ChatBubble({Key? key, required this.isUser, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      decoration: BoxDecoration(
        color: isUser ? const Color(0xFF133E87) : const Color(0xFFCCDFFF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isUser ? 13 : 2),
          topRight: const Radius.circular(12),
          bottomLeft: const Radius.circular(13),
          bottomRight: Radius.circular(isUser ? 2 : 13),
        ),
      ),
      child: TextUtils.textDescription(
        text,
        disTextColor: isUser ? Colors.white : const Color(0xFF133E87),
      ),
    );
  }
}
