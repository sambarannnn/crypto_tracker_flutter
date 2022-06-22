import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'network_helper.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  final prices;
  PriceScreen({required this.prices});
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  late Map data;
  @override
  void initState() {
    super.initState();
    data = widget.prices;
  }

  int selectedCurrency = 0;
  // DropdownButton getDropdownButton() {
  //   return DropdownButton<String>(
  //     menuMaxHeight: 250,
  //     value: selectedCurrency,
  //     items: currenciesList
  //         .map(
  //           (element) => (DropdownMenuItem<String>(
  //             value: element,
  //             child: Text(
  //               element,
  //             ),
  //           )),
  //         )
  //         .toList(),
  //     onChanged: (value) {
  //       setState(() {
  //         selectedCurrency = value!;
  //       });
  //     },
  //   );
  // }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) async {
        String current = currenciesList[selectedIndex];
        NetworkHelper networkHelper = NetworkHelper(currency: current);
        var newData = await networkHelper.getData();
        // print(newData);
        setState(() {
          data = newData;
          selectedCurrency = selectedIndex;
        });
      },
      children: currenciesList
          .map((element) => Text(
                element,
                style: TextStyle(color: Colors.white),
              ))
          .cast<Widget>()
          .toList(),
    );
  }

  List<Widget> getList() {
    List<Widget> list = [];
    for (var element in cryptoList) {
      var rate = (data[element]);
      list.add(Card(
        color: Color(0xFF1D1E33),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $element = ${rate.toString() == 'null' ? 'X' : rate.toStringAsFixed(2)} ${currenciesList[selectedCurrency]}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: getList(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Color(0xFFEB1555),
            child: Platform.isIOS ? iOSPicker() : iOSPicker(),
          ),
        ],
      ),
    );
  }
}
