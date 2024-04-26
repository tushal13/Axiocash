import 'package:axiocash/controller/AxioController.dart';
import 'package:axiocash/controller/CalenderControlle.dart';
import 'package:axiocash/controller/ThemeController.dart';
import 'package:axiocash/views/screen/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/PageIndexPage.dart';
import 'helper/DbHelper.dart';

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
