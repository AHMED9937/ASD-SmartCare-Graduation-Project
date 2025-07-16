import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorsList/model/GetDoctorsListModel.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  final String DoctorName;
  Chat({super.key, required this.DoctorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithLogo(context),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextUtils.textHeader("${DoctorName}",fontSize: 20),
            Expanded(
              child: ListView(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Color(0xFFCCDFFF),
                        size: 33,
                      ),
                      ChatBubble(
                          isUser: true,
                          text:
                              "Hello,vxxxvxvbcbvcbvcvvvvvvvvvvvvvvvv How can I help?"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ChatBubble(isUser: false, text: "Lorem ipsum"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Color(0xFFCCDFFF),
                        size: 33,
                      ),
                      ChatBubble(
                          isUser: true,
                          text:
                              "Hello,vxxxvxvbcbvcbvcvvvvvvvvvvvvvvvv How can I help?"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ChatBubble(isUser: false, text: "Lorem ipsum"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Color(0xFFCCDFFF),
                        size: 33,
                      ),
                      ChatBubble(
                          isUser: true,
                          text:
                              "Hello,vxxxvxvbcbvcbvcvvvvvvvvvvvvvvvv How can I help?"),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'How can I help you?',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0xFF25B9D3),
                    child: IconButton(
                      icon: Icon(color: Colors.white, Icons.send),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isUser;
  final String text;

  ChatBubble({required this.isUser, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        margin: EdgeInsets.symmetric(vertical: 4.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width *
              0.7, // Set max width to allow wrapping but control width
        ),
        decoration: BoxDecoration(
            color: isUser ? Colors.blue[100] : Colors.grey[300],
            borderRadius: isUser
                ? BorderRadius.only(
                    bottomRight: Radius.circular(13),
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(2),
                  )
                : BorderRadius.only(
                    bottomRight: Radius.circular(2),
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(13),
                  )),
        child: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
