import 'package:chat_app/modules/constants.dart';
import 'package:chat_app/screens/conversationpage.dart.dart';
import 'package:chat_app/services/authentication.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/services/helperfunctions.dart';
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
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConversationPage(snapshot
                                    .data.documents.data['chatRoomID'])));
                      },
                      trailing: CircleAvatar(
                        backgroundColor: Colors.green,
                        // child: Text('${username.substring(0,1).toUpperCase()}'),
                      ),
                      title: Text(snapshot
                          .data.documents[index].data['chatRoomID']
                          .toString()
                          .replaceAll('_', '')
                          .replaceAll(Constants.myName, '')),
                    );
                  })
              : Container();
        });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunction.getUserNamePrefence();

    DB().getUserChats(Constants.myName).then((value) => chatRoomStream);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          GestureDetector(
              onTap: () {
                Auth().sigOut();
              },
              child: Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed('/search');
          }),
      body: chatRoomList(),
    );
  }
}
