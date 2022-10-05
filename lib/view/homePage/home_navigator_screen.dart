import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskriverpod/view/auth/signUp/sign_up_screen.dart';
import 'package:taskriverpod/view/homePage/home_page_screen.dart';
import 'package:taskriverpod/view/profile/profile_screen.dart';


class HomeNavigator extends StatefulWidget {
  const HomeNavigator({Key? key}) : super(key: key);

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List pages = [
    const HomePage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages.elementAt(_page),
    ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: <Widget>[
          const Icon(
            CupertinoIcons.home,
            size: 30,
            color: Colors.black,
          ),
          const Icon(
            Icons.person_pin,
            size: 30,
            color: Colors.black,
          ),
        ],
        // color: AppConstants.skobeloff1,
        // buttonBackgroundColor: AppConstants.skobeloff1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
