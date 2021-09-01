import 'package:flutter/material.dart';
import 'package:home_checklist/page/home/home_page.dart';
import 'package:home_checklist/page/login/login_social.dart';
import 'package:home_checklist/page/save/saved_list.dart';
import 'package:home_checklist/viewmodel/login_view_model.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SavedList(),
    // LoginSocial(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _loginViewModel = context.watch<LoginViewModel>();

    return Scaffold(
      // 로그인 되었는지 체크
      body: _loginViewModel.isLogin ? _pages[_selectedIndex] : LoginSocial(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_sharp),
            label: '저장목록',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   label: '내정보',
          // ),
        ],
      ),
    );
  }
}

