import 'package:client_saar/zord.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'constant/my_color.dart';
import 'home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var primaryColor = MaterialColor(0xFF004182, {
    50: Color(0xFFE6F2FF),
    100: Color(0xFFB3D1E6),
    200: Color(0xFF80AFE6),
    300: Color(0xFF4D8CE6),
    400: Color(0xFF266FD1),
    500: Color(0xFF004182),
    600: Color(0xFF003B78),
    700: Color(0xFF00336E),
    800: Color(0xFF002C64),
    900: Color(0xFF001D4F)
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'أعماق التميز',
      locale: const Locale('ar'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar'),
      ],
      theme: ThemeData(
        primarySwatch: primaryColor,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: MyColor.navyColor,
          foregroundColor: MyColor.whiteColor,
        ),
        scaffoldBackgroundColor: MyColor.yellowColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: MyColor.navyColor,
          centerTitle: true,
        ),
      ),
      initialRoute: HomeScreen.routeNAme,
      routes: {
        HomeScreen.routeNAme: (context) => HomeScreen(),
        Zord.routeName: (context) => Zord(),
      },
    );
  }
}
