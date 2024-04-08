import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:axiocash/views/screen/addpage.dart';
import 'package:axiocash/views/screen/calender_page.dart';
import 'package:axiocash/views/screen/history_page.dart';
import 'package:axiocash/views/screen/homepage.dart';
import 'package:axiocash/views/screen/reminder_page.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../controller/ThemeController.dart';
import '../../controller/pageindex_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeController>(context).isDark;
    return Scaffold(
        body: Consumer<PageIndexController>(builder: (context, pro, child) {
          return IndexedStack(
            index: pro.currentPage,
            children: [
              HomePage(),
              CalenderPage(),
              ReminderPage(),
              HistoryPage()
            ],
          );
        }),
        bottomNavigationBar:
            Consumer<PageIndexController>(builder: (context, pro, child) {
          return AnimatedBottomNavigationBar(
            activeColor: Colors.cyan,
            splashColor: Colors.blue,
            backgroundColor: isDark ? Colors.black : Colors.white,
            inactiveColor:
                isDark ? Colors.white : Colors.black.withOpacity(0.5),
            icons: const [
              FluentIcons.home_48_filled,
              FluentIcons.calendar_48_filled,
              CupertinoIcons.bell,
              FluentIcons.history_48_filled
            ],
            activeIndex: pro.currentPage,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            leftCornerRadius: 10,
            iconSize: 25,
            rightCornerRadius: 10,
            onTap: (index) {
              pro.currentPage = index;
            },
          );
        }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          shape: CircleBorder(),
          backgroundColor: Colors.blue,
          onPressed: () async {
            Navigator.of(context).push(
              PageTransition(
                type: PageTransitionType.scale,
                alignment: Alignment.bottomCenter, // or any other alignment
                child: AddTransaction(),
              ),
            );
          },
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}
