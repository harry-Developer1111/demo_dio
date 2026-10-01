import 'package:demo_dio/app_colors/app_colors.dart';
import 'package:demo_dio/screens/bottom_screen/homeworkpage/homeWorkPage.dart';
import 'package:demo_dio/screens/bottom_screen/profileScreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Current selected tab
  int selectedIndex = 0;

  // Bottom navigation ki screens
  final List<Widget> screens = [
    const Homeworkpage(),
    const Profilescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.btnAuthClr,
        unselectedItemColor: AppColors.grey,
        currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
              label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile'
            ),
          ]

      ),
    );
  }
}
