import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'PKR',
  'USD',
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
  'ZAR',
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

const baseUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'C0E20635-D09B-4C24-8230-FEBC22E13D12';

Map<String, String> cryptoPrices = {};

class CoinData {
  //api calling method
  Future getCoinData(String selectedCurrency) async {
    for (String crypto in cryptoList) {
      var requestURL =
          Uri.parse('$baseUrl/$crypto/$selectedCurrency?apikey=$apiKey');
      var response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double price = decodedData['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
