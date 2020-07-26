import 'package:chat_app/modules/constants.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/flat_widgets/flat_action_btn.dart';
import 'package:chat_app/widgets/flat_widgets/flat_chat_message.dart';
import 'package:chat_app/widgets/flat_widgets/flat_message_input_box.dart';
import 'package:chat_app/widgets/flat_widgets/flat_page_header.dart';
import 'package:chat_app/widgets/flat_widgets/flat_page_wrapper.dart';
import 'package:chat_app/widgets/flat_widgets/flat_profile_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget {
  final String chatRoomId, userChatName;
  ConversationPage(this.chatRoomId, this.userChatName);
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  Stream<QuerySnapshot> conversationMessageStream;
  TextEditingController messageController = new TextEditingController();

  Widget chatMessageList() {
    return StreamBuilder(
        stream: conversationMessageStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                        snapshot.data.documents[index].data['message'],
                        snapshot.data.documents[index].data['sendBy'] ==
                            Constants.myName);
                  },
                )
              : Container();
        });
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        'message': messageController.text,
        'sendBy': Constants.myName,
        'time': DateTime.now().millisecondsSinceEpoch
      };
      DB().addMessage(widget.chatRoomId, messageMap);
      messageController.text = '';
      setState(() {
        messageController.text = '';
      });
    } else {
      print('message not sent');
    }
  }

  @override
  void initState() {
    DB().getConversationMessage(widget.chatRoomId).then((val) {
      setState(() {
        conversationMessageStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlatPageWrapper(
        scrollType: ScrollType.floatingHeader,
        reverseBodyList: true,
        header: FlatPageHeader(
          prefixWidget: FlatActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: widget.userChatName,
          suffixWidget: FlatProfileImage(
            size: 35.0,
            onlineIndicator: false,
            imageUrl: null,
            onPressed: () {
              print("Clicked Profile Image");
            },
          ),
        ),
        children: [chatMessageList()],
        footer: FlatMessageInputBox(
          onPressed: () {
            sendMessage();
          },
          onChanged: messageController,
          roundedCorners: true,
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return FlatChatMessage(
      message: message,
      messageType: isSendByMe ? MessageType.sent : null,
    );
  }
}
