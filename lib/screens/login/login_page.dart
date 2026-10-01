import 'dart:math';

import 'package:demo_dio/core/network/api_service.dart';
import 'package:demo_dio/repositories/auth_repositary.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_colors/app_colors.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  final formKey=GlobalKey<FormState>();
  bool hidePassword=true;
  late final AuthRepositaryLogin authRepository;
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    authRepository=AuthRepositaryLogin(ApiService(),);
  }

  Future<void> userLogin() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = await authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final pref = await SharedPreferences.getInstance();

      await pref.setBool("isLogin", true);
      await pref.setString("userName", user.name);
      await pref.setString("userEmail", user.email);
      await pref.setInt("userId", user.id);

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      context.go('/home');

    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            left: 20,
            right: 20,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            context.go('/register');
          },
          child: Icon
            (Icons.arrow_back),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: isLoading==true ?Center(
            child: CircularProgressIndicator(),):Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/login_pic.png'),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Log In",
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            prefix: Icon(Icons.email),
                            label: Text('Email'),
                            hintText: 'Enter Email',
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          } else if (!value.contains('@gmail.com')) {
                            return 'Please add @gmail.com';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                            prefix: Icon(Icons.password),
                            label: Text('Password'),
                            hintText: 'Enter Password',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          } else if (!(value.length > 8)) {
                            return 'Password length atleast 8 Characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                        if(formKey.currentState!.validate()){
                          userLogin();
                        }
                        },
                        child: const Text('Login'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.btnAuthClr,
                            foregroundColor: AppColors.white,
                            minimumSize: const Size(double.infinity, 54),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6,),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          height: 2,
                          color: AppColors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text('Or',style: TextStyle(
                          fontSize: 14,
                          color: AppColors.black
                        ),),
                      ),
                      Expanded(
                        child: Divider(
                          height: 2,
                          color: AppColors.grey,
                        ),
                      )
                    ],
                  ),
                ),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don’t have an account?',style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 16,
                    ),),
                    SizedBox(width: 5,),
                    InkWell(
                      onTap: (){
                        context.go('/register');
                      },
                      child: Text('Sign Up',style: TextStyle(
                          color: AppColors.btnAuthClr,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                      ),),
                    )
                  ],
                )
            
              ],
            ),
          ),
        ),
      );
  }
}
