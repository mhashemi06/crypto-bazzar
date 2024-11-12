import 'package:crypto_bazar/api/api.dart';
import 'package:crypto_bazar/constnts/colors.dart';
import 'package:crypto_bazar/models/crypto_model.dart';
import 'package:crypto_bazar/screens/coin_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<CryptoModel> cryptoList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'به کریپتو بازار خوش آمدید',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: greyColor,
                    fontSize: 20,
                    fontFamily: 'mh',
                  ),
                ),
              ),
              Text(
                'لطفا از فیلتر شکن استفاده کنید',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: greyColor,
                  fontSize: 12,
                  fontFamily: 'mh',
                ),
              ),
              SizedBox(height: 20,),
              SpinKitFadingCircle(
                color: Colors.white,
                size: 30.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  getData() async {
    (List<CryptoModel>?, Exception?) response;
    try {
      response = await Api.getCryptoList();
      if (response.$1 != null) {
        cryptoList.addAll(response.$1!);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CoinListScreen(cryptoList: cryptoList),
          ),
        );
      } else {
        print('Error');
      }
    } catch (e) {
      return ScaffoldMessenger(
        child: Text(
          'خطا: لطفا با فیلتر شکن روشن امتحان کنید.',
          style: TextStyle(
            color: greyColor,
            fontSize: 15,
            fontFamily: 'mh',
          ),
        ),
      );
    }
  }
}
