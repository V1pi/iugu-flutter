library iugu;

import 'dart:convert';

import 'package:iugu/utils.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

class Iugu {
  String get url => "https://api.iugu.com";
  String get version => "v1";
  final String auth;

  Iugu({ String apiToken }) : auth = "Basic " + base64.encode(latin1.encode('$apiToken:')).trim();

  Future<IuguToken> createPaymentIuguToken(IuguToken token) async {
    IuguToken resultIuguToken;

    String action = "payment_token";
    if(!IuguUtils.validateAccountID(token.accountId)) {
      throw "AccountID inválido.";
    }
    if(token.creditCard == null || !IuguUtils.validateCreditCardNumber(token.creditCard.number)) {
      throw "Cartão de crédito inválido.";
    }

    final response = await http.post(url + "/" + version + "/" + action, body: json.encode(token.toJson()));
    
    if(response.statusCode == 200) {
      resultIuguToken = IuguToken.fromJson(json.decode(response.body));
      resultIuguToken.creditCard.id = resultIuguToken.id;    
    } else {
      throw "Ocorreu um erro durante a comunicação com o servidor: " + response.body;
    }
    
    return resultIuguToken;
  }

  Future<IuguClient> createClient(IuguClient client) async {
    IuguClient resultClient;
    String action = "customers";
    if(client.email == null || client.email.isEmpty) {
      throw "É obrigatório que haja um email";
    }

    if(client.name == null || client.name.isEmpty) {
      throw "É obrigatório que haja um nome";
    }

    final fullURL = url + "/" + version + "/" + action;
    final response = await http.post(fullURL, body: json.encode(client.toJson()),headers: { "Authorization": auth, "Content-type": "application/json" });
    String body = response.body;

    if(response.statusCode == 200) {
      resultClient = IuguClient.fromJson(json.decode(body));
    } else {      
      throw "Ocorreu um erro durante a comunicação com o servidor: " + body;
    }

    return resultClient;
     
  }

  Future<IuguPaymentMethod> createPaymentMethod(String customerId, String  token, String description, { bool setAsDefault = false }) async {
    IuguPaymentMethod resultIuguToken;
    String action = "payment_methods";

    if(!IuguUtils.validateAccountID(customerId)) {
      throw "AccountID inválido.";
    }

    var paymentMethod = {
      "description": description,
      "token": token,
      "set_as_default": setAsDefault
    };

    final fullURL = url + "/" + version + "/customers/" + customerId + "/" + action;

    final response = await http.post(fullURL, body: json.encode(paymentMethod), headers: { "Authorization": auth, "Content-type": "application/json" });
    String body = response.body;

    if(response.statusCode == 200) {
      resultIuguToken = IuguPaymentMethod.fromJson(json.decode(body));
    } else {
      throw "Ocorreu um erro durante a comunicação com o servidor: " + body;
    }
    
    return resultIuguToken;
  }
}
