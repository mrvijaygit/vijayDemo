import 'package:flutter/material.dart';
import 'package:instagram_demo/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram_demo/screens/splash_screen.dart';
import 'package:instagram_demo/widgets/my_bottom_nav.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InstagramDemo',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: GoogleFonts.openSans().fontFamily,
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.brown)
            .copyWith(secondary: Colors.greenAccent.shade700),
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        SplashScreen.routeName: (context) => const SplashScreen(),
      },
    );
  }
}
