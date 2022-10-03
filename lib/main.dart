import 'package:flutter/material.dart';
import 'package:gadgethome/constants/constants.dart';
import 'package:gadgethome/controllers/userprovider.dart';
import 'package:gadgethome/screens/addpostscreen.dart';
import 'package:gadgethome/screens/homepage.dart';
import 'package:gadgethome/screens/login.dart';
import 'package:gadgethome/screens/register.dart';
import 'package:gadgethome/screens/searchscreen.dart';
import 'package:gadgethome/screens/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gadget Home',
      theme: ThemeData(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SPLASH_SCREEN,
      routes: <String, WidgetBuilder>{
        MAIN_UI: (BuildContext context) => const HomePage(),
        LOGIN_SCREEN: (BuildContext context) => const LoginScreen(),
        REGISTRATION_SCREEN: (BuildContext context) => const RegisterScreen(),
        SPLASH_SCREEN: (BuildContext context) => const AnimatedSplashScreen(),
        ADD_POST: (BuildContext context) => const AddPost(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == SEARCH_SCREEN) {
          final arg = settings.arguments;

          return MaterialPageRoute(builder: (context) {
            return SearchScreen(searchKey: arg);
          });
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
