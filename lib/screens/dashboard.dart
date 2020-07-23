import 'package:chat_app/modules/constants.dart';
import 'package:chat_app/screens/conversationpage.dart.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/services/helperfunctions.dart';
import 'package:chat_app/widgets/flat_widgets/flat_action_btn.dart';
import 'package:chat_app/widgets/flat_widgets/flat_chat_item.dart';
import 'package:chat_app/widgets/flat_widgets/flat_page_header.dart';
import 'package:chat_app/widgets/flat_widgets/flat_page_wrapper.dart';
import 'package:chat_app/widgets/flat_widgets/flat_profile_image.dart';
import 'package:chat_app/widgets/flat_widgets/flat_section_header.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Stream chatRoomStream;

  Widget chatRoomList() {
    return StreamBuilder(
        stream: chatRoomStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return FlatChatItem(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConversationPage(
                                    snapshot.data.documents[index]
                                        .data['chatRoomID'],
                                    snapshot.data.documents[index]
                                        .data['chatRoomID']
                                        .toString()
                                        .replaceAll('_', '')
                                        .replaceAll(Constants.myName, ''))));
                      },
                      profileImage: FlatProfileImage(
                        onlineIndicator: true,
                        imageUrl:
                            "https://images.unsplash.com/photo-1573488693582-260a6f1a51c5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1356&q=80",
                      ),
                      name: snapshot.data.documents[index].data['chatRoomID']
                          .toString()
                          .replaceAll('_', '')
                          .replaceAll(Constants.myName, ''),
                    );
                  })
              : Container(
                  child: Center(child: Text('No Chats')),
                );
        });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunction.getUserNamePrefence();
    DB().getUserChats(Constants.myName).then((value) {
      chatRoomStream = value;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlatPageWrapper(
        scrollType: ScrollType.floatingHeader,
        header: FlatPageHeader(
          prefixWidget: FlatActionButton(
            iconData: Icons.menu,
          ),
          title: "Chatty",
          suffixWidget: FlatActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/search');
            },
            iconData: Icons.search,
          ),
        ),
        children: [
          FlatSectionHeader(
            title: "Chats",
          ),
          chatRoomList()
        ],
      ),
    );
  }
}
