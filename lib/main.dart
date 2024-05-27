import 'package:examen_final_esteva/preferences/preferences.dart';
import 'package:examen_final_esteva/provider/firebase_provider.dart';
import 'package:examen_final_esteva/provider/lofin_form_validator.dart';
import 'package:examen_final_esteva/screens/details_screen.dart';
import 'package:examen_final_esteva/screens/home_screen.dart';
import 'package:examen_final_esteva/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  const AppState();

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginFormValidator(),
        ),
        ChangeNotifierProvider(
          create: (_) => FireBaseProvider(),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productes App',
      initialRoute: Preferences.user != "" && Preferences.password != ""
          ? 'home'
          : 'login',
      routes: {
        'login': (_) => LoginScreen(),
        'home': (_) => HomeScreen(),
        'details': (_) => DetailsScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
      ),
    );
  }
}
