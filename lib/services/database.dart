import 'package:cloud_firestore/cloud_firestore.dart';

class DB {
  CollectionReference fireUsers = Firestore.instance.collection('users');
  CollectionReference fireChatRoom = Firestore.instance.collection('chatroom');

//geting a specific user info to check if they are registered with the app
  getUser(String username) async {
    return await fireUsers
        .where('username', isEqualTo: username)
        .getDocuments();
  }

  //geting a specific users Username
  getUserName(String email) async {
    return await fireUsers.where('email', isEqualTo: email).getDocuments();
  }

//saving user data to database
  uploadUserInfo(userMap) {
    fireUsers.add(userMap).catchError((e) {
      print('error uploading user' + e.toString());
    });
  }

//creating a chat history
  createChatRoom(String chatRoomId, chatRoomMap) {
    fireChatRoom.document(chatRoomId).setData(chatRoomMap).catchError((e) {
      print('error creating chat room' + e);
    });
  }

  //adding conversations message
  Future<void> addMessage(String chatRoomId, messageMap) {
    return fireChatRoom
        .document(chatRoomId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print('message error' + e.toString());
    });
  }

//getting useers Chayts
 getUserChats(String itIsMyName) async {
    return fireChatRoom.where('users', arrayContains: itIsMyName).snapshots();
  }

  getConversationMessage(String chatRoomId) async{
    return  fireChatRoom.document(chatRoomId).collection('chats').orderBy('time').snapshots();
  }
}
