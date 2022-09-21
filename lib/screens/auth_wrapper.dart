import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/providers/app_provider.dart';
import 'package:survey_app/screens/login_screen.dart';
import 'package:survey_app/screens/register_screen.dart';
import 'app_navigation.dart';

class AuthenticationWraper extends StatelessWidget {
  const AuthenticationWraper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return const AppNavigation();
        }else{
          if (Provider.of<AppProvider>(context).showAuth == false){
            return const LoginScreen();
          }else{
            return const RegisterScreen();
          }
        }
      }
    );
  }
}