import 'package:http/http.dart' as http;
import 'dart:convert';
import 'coin_data.dart';


const kURL='https://rest.coinapi.io/v1/exchangerate/BTC/USD';
const kApiKey='9A68AD8C-B7E6-42C5-B352-9B7A70F26948';

class NetworkHelper
{
  String currency;
  double rates;

  //NetworkHelper(this.currency,this.crypto);
  String crypto ;

  Future sendingRequest(currency, crypto) async{

    http.Response response = await http.get('https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$kApiKey');
    print(response.statusCode);
    var jsonRawData=response.body;
    var rate= await jsonDecode(jsonRawData);

    return rate;
  }


}