import 'package:crypto_bazar/api/api.dart';
import 'package:crypto_bazar/constnts/colors.dart';
import 'package:crypto_bazar/models/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CoinListScreen extends StatefulWidget {
  final List<CryptoModel>? cryptoList;

  const CoinListScreen({super.key, this.cryptoList});

  @override
  State<CoinListScreen> createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  List<CryptoModel> cryptoList = [];
  List<CryptoModel> freshList = [];
  bool isSearchLoading = false;

  @override
  void initState() {
    super.initState();
    cryptoList = widget.cryptoList!;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: blackColor,
        appBar: appBarWidget(),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    onChanged: (value) {
                      _filterList(value);
                    },
                    decoration: InputDecoration(
                        fillColor: greenColor,
                        filled: true,
                        hintText: 'اسم رمز ارز معتبر خودتون رو سرچ کنید',
                        hintStyle: TextStyle(
                          fontFamily: 'mh',
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(style: BorderStyle.none))),
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  backgroundColor: greenColor,
                  color: blackColor,
                  onRefresh: () async {
                    await getData();
                  },
                  child: Builder(builder: (context) {
                    if (cryptoList.isEmpty && !isSearchLoading) {
                      return Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'آیتمی برای نمایش وجود ندارد',
                          style: TextStyle(
                            color: greyColor,
                            fontFamily: 'mh',
                            fontSize: 16,
                          ),
                        ),
                      );
                    }
                    if (isSearchLoading) {
                      return Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          '...در حال اپدیت اطلاعات رمز ارزها',
                          style: TextStyle(
                            color: greyColor,
                            fontFamily: 'mh',
                            fontSize: 16,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: cryptoList.length,
                      itemBuilder: (context, index) {
                        var crypto = cryptoList[index];
                        if (cryptoList.isEmpty) {
                          return Text('Empty');
                        }
                        return getListViewItems(crypto);
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getChangePercentIcon(CryptoModel crypto) {
    if (crypto.changePercent24Hr! >= 0) {
      return SizedBox(
        width: 30,
        child: Center(
          child: Icon(
            Icons.trending_down,
            size: 24,
            color: redColor,
          ),
        ),
      );
    }
    return SizedBox(
      width: 30,
      child: Center(
        child: Icon(
          Icons.trending_up,
          size: 24,
          color: greenColor,
        ),
      ),
    );
  }

  Widget getListViewItems(CryptoModel crypto) {
    return SizedBox(
      child: ListTile(
        title: Text(
          crypto.name.toString(),
          style: TextStyle(color: greenColor),
        ),
        subtitle: Text(
          crypto.symbol.toString(),
          style: TextStyle(color: greyColor),
        ),
        leading: SizedBox(
          width: 30,
          child: Center(
            child: Text(
              crypto.rank.toString(),
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ),
        trailing: SizedBox(
          width: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    crypto.priceUsd!.toStringAsFixed(2),
                    style: TextStyle(
                      color: greyColor,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    crypto.changePercent24Hr!.toStringAsFixed(2),
                    style: TextStyle(
                      color: crypto.changePercent24Hr! >= 0
                          ? greenColor
                          : redColor,
                    ),
                  ),
                ],
              ),
              _getChangePercentIcon(crypto)
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'کریپتو بازار',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'mh',
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      backgroundColor: blackColor,
    );
  }

  Future<void> getData() async {
    (List<CryptoModel>?, Exception?) response;

    response = await Api.getCryptoList();
    if (response.$1 != null) {
      setState(() {
        isSearchLoading = true;
      });
      cryptoList.clear();
      cryptoList.addAll(response.$1!);
      setState(() {
        isSearchLoading = false;
      });
    } else {
      print('Error');
    }
  }

  Future<void> _filterList(String userSearch) async {
    if (userSearch.isEmpty) {
      setState(() {
        isSearchLoading = true;
      });
      cryptoList.clear();
      (List<CryptoModel>?, Exception?) result = await Api.getCryptoList();

      if (result.$1 != null) {
        setState(() {
          cryptoList = result.$1!;
          isSearchLoading = false;
        });
      }
    } else {
      List<CryptoModel> searchList = [];
      searchList = cryptoList.where((element) {
        return element.name!.toLowerCase().contains(userSearch.toLowerCase());
      }).toList();
      setState(() {
        cryptoList = searchList;
      });
    }
  }
}
