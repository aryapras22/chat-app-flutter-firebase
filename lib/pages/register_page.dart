// ignore_for_file: prefer_const_constructors

import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController =
      TextEditingController();
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  void registerUser(context) {
    final _auth = AuthService();
    if (_passwordController == _passwordController) {
      try {
        _auth.signUpWithEmailPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Password aren't same"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Logo
          Center(
            child: Icon(
              Icons.chat,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 50),
          // welcome back message
          Text(
            "Let's an account for you",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 25),
          // email textfield
          MyTextField(
            hintText: "Email",
            controller: _emailController,
            obscureText: false,
          ),
          SizedBox(height: 10),
          // pw textfield
          MyTextField(
            hintText: "Password",
            controller: _passwordController,
            obscureText: true,
          ),
          SizedBox(height: 10),
          // pw textfield
          MyTextField(
            hintText: "Confirm Password",
            controller: _passwordCheckController,
            obscureText: true,
          ),
          SizedBox(height: 25),
          // login button
          MyButton(
            text: "Register",
            onTap: () => registerUser(context),
          ),
          SizedBox(height: 25),
          //register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "A Member Already? ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Login Now",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
