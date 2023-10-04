import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';




  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItems = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItems);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropDownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value!;
            getData();
          });
        });
  }

  // List<DropdownMenuItem <String>> getDropDownItems() {
  //   List<DropdownMenuItem <String>> dropDownItems = [];
  //   for (int i = 0; i < currenciesList.length; i++) {
  //     String currency = (currenciesList[i]);
  //     var newItems= DropdownMenuItem(
  //       child: Text(currency),
  //       value: currency,
  //     );
  //     dropDownItems.add(newItems);
  //   }
  //   return dropDownItems;
  // }

  CupertinoPicker IOSPicker() {
    List<Text> pickerItem = [];
    for (String currency in currenciesList) {
      var addItems = Text(currency);
      pickerItem.add(addItems);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: pickerItem,
    );
  }

  String bitCoinCurrency = '?';

  void getData() async {
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      setState(() {
        bitCoinCurrency = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitCoinCurrency $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? IOSPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}
