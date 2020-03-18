
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:iugu/iugu.dart';
import 'package:iugu/models.dart';

// iugu_services.json
// {
//      "account_id": "<accountId>",
//      "token_api": "<tokenApi>",
//      "client_id": "<validClientId>"
// }

void main() {  
  Map<String, dynamic> iuguServices;
  setUpAll(() {
    String jsonString = new File("iugu_services.json").readAsStringSync();
    iuguServices = json.decode(jsonString);  
  });
  test("should create Payment Token", () async {
    IuguToken token = new IuguToken(accountId: iuguServices["account_id"], 
      creditCard: IuguCreditCard(number: "4111111111111111", verificationValue: 472, firstName: "Vinicius", lastName: "Picanco", 
                     month: 07, year: 2021));
    Iugu iugu = new Iugu();
    IuguToken result = await iugu.createPaymentIuguToken(token);

    IuguToken expectedIuguToken = new IuguToken(accountId: null, id: result.id,
                                    creditCard: new IuguCreditCard(id: result.id , number: null, verificationValue: null, bin:"411111",
                                    firstName: null, lastName: null, month: 07, year: 2021, brand: "VISA",
                                    holderName: "Vinicius Picanco", displayNumber: "XXXX-XXXX-XXXX-1111"),
                                    test: true
                          );
    expect(result, expectedIuguToken);
  });

  test("should create client", () async {
    IuguClient client = new IuguClient(name: "Vinicius Picanco", email: "teste@teste.com");
    Iugu iugu = new Iugu(apiToken: iuguServices["token_api"]);
    IuguClient result = await iugu.createClient(client);

    IuguClient expectedIuguClient = new IuguClient(id: result.id, name: "Vinicius Picanco", email: "teste@teste.com",
                                                  createdAt: result.createdAt, updatedAt: result.updatedAt, customVariables: []);

    expect(result, expectedIuguClient);
  });

  test("should create payment method", () async {
    Iugu iugu = new Iugu(apiToken: iuguServices["token_api"]);

     IuguToken token = new IuguToken(accountId: iuguServices["account_id"], 
                                    creditCard: IuguCreditCard(number: "4111111111111111", verificationValue: 472, firstName: "Vinicius", lastName: "Picanco", 
                                                  month: 07, year: 2021)
                                    );
      token = await iugu.createPaymentIuguToken(token);
      await iugu.createPaymentMethod(iuguServices["client_id"], token.id, "Meu cartao");

  });
}