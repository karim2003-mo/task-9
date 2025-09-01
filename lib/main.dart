import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task9/core/routes/routes.dart';
import 'package:task9/features/auth/presentation/pages/signin.dart';
import 'package:task9/features/products/presentation/Pages/testscreen.dart';
import 'package:task9/firebase_options.dart';
import 'dependency injection/di_container.dart' show setupLocator;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  setupLocator();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations', // <-- change the path of the translation files 
      fallbackLocale: Locale('en', 'US'),
      child: MainApp()
    ),);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home:(FirebaseAuth.instance.currentUser!=null)?Testscreen():SigIn(),
      routes:Routes.routes ,
    );
  }
}
