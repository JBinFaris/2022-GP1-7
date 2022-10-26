import 'package:faydh/UserProfile.dart';
import 'package:faydh/awarenessPost.dart';
import 'package:faydh/individual.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List<Widget> _screens = [individual(), awarenessPost(), UserProfile()];

  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        unselectedLabelStyle:
            const TextStyle(color: Color(0xFF1A4D2E), fontSize: 14),
        backgroundColor: Color(0xFF1A4D2E),
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white, //<-- add this
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _selectedIndex == 0 ? Color(0xFFD6ECD0) : Colors.white,
              size: 35,
            ),
            label: "الصفحة الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.playlist_add,
              color: _selectedIndex == 1 ? Color(0xFFD6ECD0) : Colors.white,
              size: 35,
            ),
            label: "المنتدى التوعوي",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _selectedIndex == 2 ? Color(0xFFD6ECD0) : Colors.white,
              size: 35,
            ),
            label: "الملف الشخصي",
          ),
        ],
      ),
    );
  }
}
