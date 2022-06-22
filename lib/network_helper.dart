import 'package:bitcoin_ticker/coin_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  late String currency;
  NetworkHelper({required this.currency});
  Future getValue(coin) async {
    //https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=313528AA-2303-4261-9A5A-3047F3CB9360
    Uri url = Uri.https('rest.coinapi.io', '/v1/exchangerate/$coin/$currency', {
      'apikey': '0C019F73-99B2-44C5-A76E-F1E41E9F1272',
    });
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      // print(decodedData);
      return decodedData["rate"];
    } else {
      print(url);
    }
  }

  Future<Map> getData() async {
    var coinMap = {};
    for (String coin in cryptoList) {
      var rate = await getValue(coin);
      coinMap.putIfAbsent(coin, () => rate);
    }
    return coinMap;
  }
}
