import 'package:crypto_bazar/models/crypto_model.dart';
import 'package:dio/dio.dart';

class Api {
  Api._();

  static Future<(List<CryptoModel>?, Exception?)> getCryptoList() async {
    print('123');
    List<CryptoModel> cryptoList;
    try {
      final dio = Dio();
      var response = await dio.get('https://api.coincap.io/v2/assets');
      cryptoList = response.data['data']
          .map<CryptoModel>((e) => CryptoModel.fromJson(e))
          .toList();
      return (cryptoList, null);
    } catch (e) {
      rethrow;
      return (null, Exception(e));
    }
  }
}
