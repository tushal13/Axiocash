import 'package:axiocash/controller/ThemeController.dart';
import 'package:axiocash/controller/axiocontroller.dart';
import 'package:axiocash/controller/calendercontrolle.dart';
import 'package:axiocash/views/screen/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/pageindex_page.dart';
import 'helper/dbhelper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDb();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AxioController()),
        ChangeNotifierProvider(create: (context) => CalenderController()),
        ChangeNotifierProvider(create: (context) => PageIndexController()),
        ChangeNotifierProvider(create: (context) => ThemeController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Axiocash',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeController>(context).isDark
          ? ThemeData.dark()
          : ThemeData.light(),
      home: MainPage(),
    );
  }
}
