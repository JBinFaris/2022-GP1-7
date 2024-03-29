import 'package:faydh/UserProfile.dart';
import 'package:faydh/awarenessPost.dart';
import 'package:faydh/viewAllFood.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class charityHome extends StatefulWidget {
  const charityHome({super.key});

  @override
  _charityHome createState() => _charityHome();
}

class _charityHome extends State<charityHome> {
  final PageController _pageController = PageController();
  final List<Widget> _screens = [
    const viewAllFood(),
    const awarenessPost(),
    const UserProfile()
  ];

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
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A4D2E),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              onTabChange: _onItemTapped,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  iconColor: _selectedIndex == 0
                      ? const Color(0xFFD6ECD0)
                      : Colors.white,
                  text: "الصفحة الرئيسية",
                ),
                GButton(
                  icon: LineIcons.list,
                  iconColor: _selectedIndex == 1
                      ? const Color(0xFFD6ECD0)
                      : Colors.white,
                  text: "المنتدى التوعوي",
                ),
                GButton(
                  icon: LineIcons.user,
                  iconColor: _selectedIndex == 2
                      ? const Color(0xFFD6ECD0)
                      : Colors.white,
                  text: "الملف الشخصي",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
