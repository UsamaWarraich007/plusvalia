import 'package:flutter/material.dart';
import 'package:plusvalia/home.dart';
import 'package:plusvalia/my_investment.dart';
import 'package:plusvalia/my_profile.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  late List<Widget> _pages;
  late Widget _home;
  late Widget _profile;
  late Widget _investment;
  late int _currentIndex;
  late Widget _currentPage;
  @override
  void initState() {
    super.initState();
    _home = const Home();
    _profile = const MyProfile();
    _investment= const MyInvestment();

    _pages = [_profile, _home,_investment];
    _currentIndex = 1;
    _currentPage = _home;
  }
  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPage,
      //Bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        unselectedFontSize: 10,
        onTap: (value) {
          _changeTab(value);
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label:'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Investment',
            icon: Icon(Icons.star),
          ),
        ],
      ),
    );
  }
}
