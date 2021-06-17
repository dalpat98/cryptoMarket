// @dart=2.9

import 'package:crypto/Models/cryptoModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Api extends ChangeNotifier {
  CryptoModel cryptoModel;
  Future<bool> getdata() async {
    try {
      Response response = await Dio().get(
          'https://pro-api.coinmarketcap.com/v1/cryptocurrency/map',
          options: Options(headers: {
            "X-CMC_PRO_API_KEY": "2592e201-7cb0-41b4-81d5-abacc60ac4ee"
          }));
      if (response.statusCode == 200) {
        this.cryptoModel = CryptoModel.fromJson(response.data);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
