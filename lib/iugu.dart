library iugu;

import 'dart:convert';

import 'package:iugu/utils.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

class Iugu {
  String get url => "https://api.iugu.com";
  String get version => "v1";

  Future<void> createPaymentToken(Token token) async {
    String action = "payment_token";
    if(!validateAccountID(token.accountId)) {
      throw "AccountID inválido.";
    }
    if(token.creditCard == null || !validateCreditCardNumber(token.creditCard.number)) {
      throw "Cartão de crédito inválido.";
    }

    final response = await http.post(url + "/" + version + "/" + action, body: json.encode(token.toJson()));

    if(response.statusCode == 200) {
      // Code
    } else {
      throw "Ocorreu um erro durante a comunicação com o servidor";
    }
    
  }
}
