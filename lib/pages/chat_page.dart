import 'dart:html';
import 'dart:js';

import 'package:chat_app_koko/auth/auth_services.dart';
import 'package:chat_app_koko/auth/chat/chat_services.dart';
import 'package:chat_app_koko/components/chat_bubble.dart';
import 'package:chat_app_koko/components/my_textfields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //send msg
  void sendMessage() async {
    //   if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      //   send the message
      await _chatService.sendMessage(receiverID, _messageController.text);

      //   clear text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     title:  Text(receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          //   display all messages
          Expanded(
            child: _buildMessageList(),
          ),
          //   user input
          _buildUserInput(),
        ],
      ),
    );
  }

//   build message List
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverID, senderID),
        builder: (context, snapshot) {
          //   errors
          if (snapshot.hasError) {
            return const Text("Error");
          }

          //   loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading...");
          }

          //   return list view
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMesssageItem(doc))
                .toList(),
          );
        });
  }

// build message item
  Widget _buildMesssageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    // align message to the right if sender is the current user, otherwise left

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data["message"], isCurrentUser: isCurrentUser)
          ],
        ));
  }

//  build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 50,
      ),
      child: Row(
        children: [
          //   textField should take most of the space
          Expanded(
            child: MyTextField(
              controller: _messageController,
              text: 'Type a message',
              obscureText: false,
            ),
          ),

          Container(
            decoration: const BoxDecoration(
                color: Colors.green, shape: BoxShape.circle),
            margin: EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
