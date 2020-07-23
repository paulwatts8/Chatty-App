import 'package:chat_app/modules/constants.dart';
import 'package:chat_app/screens/conversationpage.dart.dart';
import 'package:chat_app/services/database.dart';
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
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => ConversationPage(chatRoomId,userName),
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
        : Container(
            color: Colors.red,
            child: Center(child: Text('no search data')),
          );
  }

//list tile which displays all users
  Widget searchTile(String userName) {
    return GestureDetector(
      onTap: () {
        createNewConversation(userName);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  userName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Spacer(),
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(80),
              ),
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: Column(children: <Widget>[
        Container(
            color: Colors.grey[350],
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: TextFormField(
                  controller: usernameController,
                  validator: (val) {
                    return val.length < 2 ? 'Input a username' : null;
                  },
                  decoration: InputDecoration(hintText: 'search Username'),
                )),
                GestureDetector(
                  onTap: () {
                    initiateSearch();
                  },
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(
                              colors: [Colors.grey[400], Colors.grey])),
                      child: Icon(Icons.search)),
                )
              ],
            )),
        searchlist()
      ])),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
