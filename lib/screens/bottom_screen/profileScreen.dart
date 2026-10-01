import 'package:demo_dio/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {

  Future<void>logout()async{
   final pref=await SharedPreferences.getInstance();

   await pref.setBool('isLogin',false);

   if(!mounted)return;
   context.go('/login');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
           logout();
          }, child: Text('logout'),
        ),
      ),
    );
  }
}
