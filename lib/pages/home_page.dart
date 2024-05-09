// ignore_for_file: prefer_const_constructors
import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  // chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _auth = AuthService();

  void logOut() {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
        centerTitle: true,
        title: SafeArea(
            child: Text(
          "Homepage",
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        )),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text("ERROR");
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loadinig");
        }
        print(snapshot.data);
        // return list view
        return ListView(
            children: snapshot.data!
                .map<Widget>(
                  (userData) => _buildUserItem(userData, context),
                )
                .toList());
      },
    );
  }

  Widget _buildUserItem(Map<String, dynamic> userData, BuildContext context) {
    // display all users except current user

    if (userData['uid'] != _auth.getCurrentUser()!.uid) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData['email'],
                receiverID: userData['uid'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
