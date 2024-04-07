import 'dart:js';

import 'package:chat_app_koko/auth/auth_services.dart';
import 'package:chat_app_koko/auth/chat/chat_services.dart';
import 'package:flutter/material.dart';

import '../components/my_drawer.dart';
import '../components/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void loOut() {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: Mydrawer(),
      body: _buildUserList(),
    );
  }

//    build a list of users except for the current logged in user

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          //   error
          if (snapshot.hasError) {
            return const Text("Error");
          }

          //   loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          //   return list view
          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

//   build indivisual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
//     display all user except current user
   if(userData["email"] != _authService.getCurrentUser()!.email){
     return UserTile(
       text: userData["email"],
       onTap: () {
         //    tap on the user page go to chat page
         Navigator.push(
             context,
             MaterialPageRoute(
                 builder: (context) => ChatPage(
                   receiverEmail: userData["email"],
                   receiverID: userData["uid"],

                 )));
       },
     );
   }else{
     return Container();
   }
  }
}
