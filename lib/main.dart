import 'package:crypto_bazar/screens/coin_list_screen.dart';
import 'package:crypto_bazar/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CryptoApplication());
}


class CryptoApplication extends StatefulWidget {
  const CryptoApplication({super.key});

  @override
  State<CryptoApplication> createState() => _CryptoApplicationState();
}

class _CryptoApplicationState extends State<CryptoApplication> {
  @override
  Widget build(BuildContext context) {
    return getMaterialApp();
  }
}


Widget getMaterialApp(){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  );
}
