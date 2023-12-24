import 'package:flutter/material.dart';
import 'package:laser_slides/controller/home_controller.dart';
import 'package:provider/provider.dart';
import 'view/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => HomeController(),
        child: HomeView(),
      ),
    );
  }
}
