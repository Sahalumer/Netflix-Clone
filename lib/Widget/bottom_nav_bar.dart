import 'package:flutter/material.dart';
import 'package:netflixclone/Screens/home_screen.dart';
import 'package:netflixclone/Screens/more_screen.dart';
import 'package:netflixclone/Screens/search_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 70,
          color: Colors.black,
          child: const TabBar(
            tabs: [
              Tab(
                text: "Home",
                icon: Icon(
                  Icons.home,
                ),
              ),
              Tab(
                text: "Search",
                icon: Icon(
                  Icons.search,
                ),
              ),
              Tab(
                text: "New & hot",
                icon: Icon(
                  Icons.photo_library_outlined,
                ),
              )
            ],
            indicatorColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xff999999),
          ),
        ),
        body: const TabBarView(
          children: [
            HomeScreen(),
            SearchScreen(),
            MoreScreen(),
          ],
        ),
      ),
    );
  }
}
