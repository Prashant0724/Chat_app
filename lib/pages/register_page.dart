import 'package:chat_app_koko/auth/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfields.dart';

class REgisterPage extends StatelessWidget {
  final void Function()? onTap;
  REgisterPage({super.key, required this.onTap});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void register(BuildContext context) {
    //   get auth service
    final _auth = AuthService();

    // if password matches , then it creates user
    if(_passwordController.text == _confirmPasswordController.text){
      try{

        _auth.signUpWithEmailPassword(
            _emailController.text, _passwordController.text);
      }catch(e){
        showDialog(context: context, builder: (context)=>AlertDialog(
          title: Text(e.toString()),
        ));
      }
    }

  //   id pw don't match , then it will show error
    else{
      showDialog(context: context, builder: (context)=>AlertDialog(
        title: Text("Password don't match"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            "Let's create an account for you",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          MyTextField(
            text: "Email",
            obscureText: false,
            controller: _emailController,
          ),
          SizedBox(
            height: 15,
          ),
          MyTextField(
            text: "Password",
            obscureText: true,
            controller: _passwordController,
          ),
          const SizedBox(
            height: 25,
          ),
          MyTextField(
            text: "ConfirmPassword",
            obscureText: true,
            controller: _confirmPasswordController,
          ),
          const SizedBox(
            height: 25,
          ),
          MyButton(
            text: "Register",
            onTap: ()=>register(context),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "LogIn now",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              )
            ],
          ),
        ],
      ),
    );
    ;
  }
}
