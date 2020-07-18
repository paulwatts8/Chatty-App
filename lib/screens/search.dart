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
    initiateSearch();
    super.initState();
  }

  initiateSearch() {
    DB().getUsers(usernameController.text).then((value) {
      setState(() {
        searchSnapshot = value;
      });
    });
  }

  //sends user to chatscreen for selected user
  createNewonversation(){

  }

  Widget searchlist() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot.documents.length,
            itemBuilder: (BuildContext context, int index) {
              return SearchTile(
                  username: searchSnapshot.documents[index].data['username']);
            },
          )
        : Container(child: Center(child: Text('no search data')),);
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
            Expanded(child: searchlist())

      ])),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String username;
  SearchTile({this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                username,
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(13)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: IconButton(icon: Icon(Icons.send), onPressed: null),
            ),
          )
        ],
      ),
    );
  }
}
