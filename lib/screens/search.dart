import 'package:chat_app/modules/constants.dart';
import 'package:chat_app/screens/conversationpage.dart.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/flat_widgets/flat_action_btn.dart';
import 'package:chat_app/widgets/flat_widgets/flat_chat_item.dart';
import 'package:chat_app/widgets/flat_widgets/flat_input_box.dart';
import 'package:chat_app/widgets/flat_widgets/flat_page_header.dart';
import 'package:chat_app/widgets/flat_widgets/flat_page_wrapper.dart';
import 'package:chat_app/widgets/flat_widgets/flat_profile_image.dart';
import 'package:chat_app/widgets/flat_widgets/flat_section_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  QuerySnapshot searchSnapshot;
  TextEditingController usernameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  initiateSearch() {
    DB().getUser(usernameController.text).then((value) {
      setState(() {
        searchSnapshot = value;
      });
    }).catchError((e) {
      print('error getting user' + e.toString());
    });
  }

  //sends user to chatscreen for selected user
  createNewConversation(String userName) {
    String chatRoomId = getChatRoomId(userName, Constants.myName);

    List<String> users = [userName, Constants.myName];
    Map<String, dynamic> chatRoomMap = {
      'users': users,
      'chatRoomID': chatRoomId,
    };
    DB().createChatRoom(chatRoomId, chatRoomMap);
    Navigator.of(context).pop();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConversationPage(chatRoomId, userName),
        ));
  }

  Widget searchlist() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot.documents.length,
            itemBuilder: (context, index) {
              return searchTile(
                  searchSnapshot.documents[index].data['username']);
            },
          )
        : Container();
  }

//list tile which displays all users
  Widget searchTile(String userName) {
    return FlatChatItem(
      message: '',
      profileImage: FlatProfileImage(
          onPressed: () {
            createNewConversation(userName);
          },
          onlineIndicator: false,
          imageUrl: null),
      name: userName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlatPageWrapper(
      scrollType: ScrollType.floatingHeader,
      header: FlatPageHeader(
        prefixWidget: FlatActionButton(
          iconData: Icons.arrow_back_ios,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: "Search",
        suffixWidget: FlatActionButton(
          iconData: Icons.contacts,
          iconColor: Colors.white,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: FlatInputBox(
                  onChanged: usernameController,
                  obsecureText: false,
                  validator: (value) {
                    return null;
                  },
                  roundedCorners: true,
                  hintText: 'Search Username....',
                ),
              ),
              FlatActionButton(
                iconData: Icons.search,
                iconSize: 35.0,
                iconColor: Colors.black,
                onPressed: () {
                  initiateSearch();
                },
              ),
            ],
          ),
        ),
        FlatSectionHeader(
          title: "Search Results",
        ),
        searchlist(),
      ],
    ));
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
