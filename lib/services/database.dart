import 'package:cloud_firestore/cloud_firestore.dart';

class DB {
  CollectionReference fireUsers = Firestore.instance.collection('users');
  CollectionReference fireChatRoom = Firestore.instance.collection('chatroom');

  Future getUsers(String username) async {
    return await fireUsers
        .where('username', isEqualTo: username)
        .getDocuments();
  }

  uploadUserInfo(userMap) {
    fireUsers.add(userMap).catchError((e) {
      print('error uploading user' + e.toString());
    });
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    fireChatRoom.document(chatRoomId).setData(chatRoomMap).catchError((e) {
      print('error creating chat room' + e);
    });
  }
}
