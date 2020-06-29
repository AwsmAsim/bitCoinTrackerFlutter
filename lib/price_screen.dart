import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'dart:math';
import 'networkHelper.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();

}

class _PriceScreenState extends State<PriceScreen> {
  NetworkHelper networkHelper;
  String selectedCurrency = 'AUD';
  List rates=[];
  //String jsonCode;
  double BTCrate=0.0;
  double ETHrate=0.0;
  double LTCrate=0.0;
  int length_of_list = currenciesList.length;

  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
  void initState(){
    super.initState();
    abc();
  }
  void abc() async{
    NetworkHelper networkHelper = await NetworkHelper();
   // for(String crypto in cryptoList) {
    for(String crypto in cryptoList)
      {
      var decodedData = await networkHelper.sendingRequest(selectedCurrency, crypto);
      var rate=decodedData['rate'];
      rates.add(rate);
      }
      setState(() {
      BTCrate = roundDouble(rates[0], 3);
      ETHrate=roundDouble(rates[1], 3);;
      LTCrate=roundDouble(rates[2], 3);;
      });
   // }
  }

  CupertinoPicker iosPicker(){

      List<Text> dropDownMenuItem= [];
      for (int i = 0; i < length_of_list; i++) {
        var newItem = Text(currenciesList[i]);
        dropDownMenuItem.add(newItem);
      }
      return CupertinoPicker(
        itemExtent: 32,
        onSelectedItemChanged: (selectedIndex) {
          selectedCurrency=currenciesList[selectedIndex];
        },
        children: dropDownMenuItem,
      );

  }

  DropdownButton<String> androidPicker(){

      List<DropdownMenuItem<String>> dropDownMenuItems = [];
      for (int i = 0; i < length_of_list; i++) {
        var newItem = DropdownMenuItem(
            child: Text(currenciesList[i]), value: currenciesList[i]);
        dropDownMenuItems.add(newItem);
      }
      return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownMenuItems,
      onChanged: (value){
        setState(() {
          selectedCurrency=value;

           });
         }
      );


  }

  Widget nativePicker(){
    if(Platform.isAndroid){
      return androidPicker();
    }
    else
      if(Platform.isAndroid){
        return iosPicker();
      }
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

                  '1 BTC = ${BTCrate} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
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
                  '1 ETH = $ETHrate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
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
                  '1 LTC = $LTCrate $selectedCurrency',
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
            child: nativePicker(),
          ),
        ],
      ),
    );
  }
}
