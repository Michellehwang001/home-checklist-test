import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_checklist/page/root_page.dart';
import 'package:home_checklist/repository/checklist_repository.dart';
import 'package:home_checklist/viewmodel/checklist_view_model.dart';
import 'package:home_checklist/viewmodel/login_view_model.dart';
import 'package:home_checklist/viewmodel/my_checklist_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(),
    ),
    ChangeNotifierProvider<ChecklistViewModel>(
      create: (context) => ChecklistViewModel(ChecklistRepository()),
    ),
    ChangeNotifierProvider<MyChecklistViewModel>(
      create: (context) => MyChecklistViewModel(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Color(0xFF4257C2),
        primarySwatch: Colors.indigo,
      ),
      home: HomeCheckList(),
    );
  }
}

class HomeCheckList extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
        body: RootPage(),
    );
  }
}
