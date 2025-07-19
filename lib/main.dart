import 'package:flutter/material.dart';
import 'package:task9/core/routes/routes.dart';
import 'package:task9/features/products/presentation/Pages/testscreen.dart';
import 'dependency injection/di_container.dart' show setupLocator;
void main() {
  setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Testscreen(),
      routes:Routes.routes ,
    );
  }
}
