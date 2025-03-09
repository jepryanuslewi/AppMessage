import 'package:app_message/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  // Get instance of firestrore and auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //   Get User Stream
  /* List<Map<String, dynamic>> = [] 
  {
    'email' : 'gmail.com'
    'id': ...
  } 
*/

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // Go through each individual user
        final user = doc.data();

        // return user
        return user;
      }).toList();
    });
  }

  // Send Message
  Future<void> sendMessage(String receiveId, message) async {
    // Get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      senderId: currentUserID,
      senderEmail: currentUserEmail,
      receiverId: receiveId,
      message: message,
      timestamp: timestamp,
    );

    // construct chat room id for the two user(sorted with uniqueness)
    List<String> ids = [currentUserID, receiveId];
    ids.sort();
    String chatRoomId = ids.join('_');
    // add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // Get Message
  Stream<QuerySnapshot> getMessages(String useId, otherUserID) {
    // construct a chatroom ID for the two users
    List<String> ids = [useId, otherUserID];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
