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
      body: Column(
        children: [
          Expanded(
            child: Center(
                child: SizedBox(
                  height: 70,
                    width: 70,
                    child: Image.asset("assets/instagramIcon.jpg"))
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                children: [
                  Text('from',style: Styles.headingStyle5(
                      color: Colors.grey,
                      isBold:true
                  ),),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(FontAwesomeIcons.meta, size: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('Meta',style: Styles.headingStyle3(
                        ),),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
