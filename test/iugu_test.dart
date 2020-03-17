
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:iugu/iugu.dart';
import 'package:iugu/models.dart';

// iugu_services.json
// {
//     "account_id": "<accountId>"
// }
void main() {  
  Map<String, dynamic> iuguServices;
  setUp(() {
    String jsonString = new File("iugu_services.json").readAsStringSync();
    iuguServices = json.decode(jsonString);  
  });
  test("should hit on server", () async {
    IuguToken token = new IuguToken(accountId: iuguServices["account_id"], 
      creditCard: IuguCreditCard(number: "4111111111111111", verificationValue: 472, firstName: "Vinicius", lastName: "Picanco", 
                     month: 07, year: 2021)
    );
    Iugu iugu = new Iugu();
    IuguToken result = await iugu.createPaymentIuguToken(token);

    IuguToken expectedIuguToken = new IuguToken(accountId: null, id: result.id,
                                    creditCard: new IuguCreditCard(number: null, verificationValue: null, bin:"411111",
                                    firstName: null, lastName: null, month: 07, year: 2021, brand: "VISA",
                                    holderName: "Vinicius Picanco", displayNumber: "XXXX-XXXX-XXXX-1111"),
                                    test: true
                          );
    expect(result, expectedIuguToken);
  });
}