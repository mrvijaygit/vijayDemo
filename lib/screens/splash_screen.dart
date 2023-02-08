import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/style.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isInit = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Future.delayed(const Duration(seconds: 6), () {});
      _getRoute();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  Future<void> _getRoute() async {
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.routeName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('WELCOME',
        style: Styles.headingStyle4(
          isBold: true
        ),),
      )
    );
  }
}
