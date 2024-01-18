import 'package:chats/controller/auth_provider.dart';
import 'package:chats/views/login.dart';
import 'package:chats/views/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginReg extends StatefulWidget {
  const LoginReg({Key? key}) : super(key: key);

  @override
  State<LoginReg> createState() => _LoginRegState();
}

class _LoginRegState extends State<LoginReg> {
  @override
  
    @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<AuthPro>(context);
    if (authprovider.showLoginPage) {
      return LoginPage(onTap: authprovider.togglepages);
    } else {
      return SignUp(onTap: authprovider.togglepages);
      
    }
  }
  
}

