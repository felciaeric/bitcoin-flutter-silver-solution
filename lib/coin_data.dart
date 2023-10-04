import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const bitCoinAverageUrl =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker';
// const apiKey = 'NjVlYTI4NDllNmU3NDZhZjk1MmE4ZDQzZDE3YjBkODM';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    String requestedUrl = '$bitCoinAverageUrl/BTC$selectedCurrency';
    http.Response response = await http.get(
      Uri.parse(requestedUrl),
      headers: {'x-ba-key': 'NjVlYTI4NDllNmU3NDZhZjk1MmE4ZDQzZDE3YjBkODM'},
    );
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      print(decodedData);
      double lastPrice = decodedData['last'];
      print(lastPrice);
      return lastPrice.toStringAsFixed(0);
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
