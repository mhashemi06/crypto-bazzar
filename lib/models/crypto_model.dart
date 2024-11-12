class CryptoModel {
  String? id;
  String? rank;
  String? symbol;
  String? name;
  double? supply;
  double? maxSupply;
  double? marketCapUsd;
  double? volumeUsd24Hr;
  double? priceUsd;
  double? changePercent24Hr;
  double? vwap24Hr;

  CryptoModel();

  CryptoModel.fromJson(Map js) {
    id = js['id'];
    rank = js['rank'];
    symbol = js['symbol'];
    name = js['name'];
    supply = double.parse(js['supply']);
   if(js['maxSupply'] !=null){
     maxSupply = double.parse(js['maxSupply']);
   }
    marketCapUsd = double.parse(js['marketCapUsd']);
    volumeUsd24Hr = double.parse(js['volumeUsd24Hr']);
    priceUsd = double.parse(js['priceUsd']);
    changePercent24Hr = double.parse(js['changePercent24Hr']);
    vwap24Hr = double.parse(js['vwap24Hr']);
  }
}
