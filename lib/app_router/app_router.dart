import 'package:demo_dio/main.dart';
import 'package:demo_dio/screens/homepage/home_page.dart';
import 'package:demo_dio/screens/login/login_page.dart';
import 'package:demo_dio/screens/register/register_page.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final router = GoRouter(
    initialLocation: '/register',
    redirect: (context,state)async{
      final pref=await SharedPreferences.getInstance();
      final isLogin= pref.getBool('isLogin') ?? false;

      final signUpPage=state.matchedLocation=='/register';
      final loginPage=state.matchedLocation=='/login';

      if(isLogin && (signUpPage||loginPage)){
        return'/home';
      }
      if(!isLogin && state.matchedLocation=='/home'){
        return'/login';
      }
      return null;

    },
    routes: [
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage()),
  GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage())
]);
