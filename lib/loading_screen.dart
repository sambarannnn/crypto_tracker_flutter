import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'price_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'network_helper.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var data = new Map();
  @override
  void initState() {
    super.initState();
    getDataFromApi();
  }

  void getDataFromApi() async {
    String selectedCurrency = 'USD';
    NetworkHelper networkHelper = NetworkHelper(currency: selectedCurrency);
    data = await networkHelper.getData();
    // print(data);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(
        prices: data,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
