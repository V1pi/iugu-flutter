import 'package:flutter_test/flutter_test.dart';

import '../lib/iugu.dart';
import '../lib/models.dart';

void main() {
  test("should hit on server", () async {
    Token token = new Token(accountId: "ENTER WITH YOUR ACCOUNT ID", 
      creditCard: CreditCard(number: "4111111111111111", verificationValue: 472, firstName: "Vinicius", lastName: "Picanco", 
                     month: 07, year: 2021)
    );

    Iugu iugu = new Iugu();
    await iugu.createPaymentToken(token);
  });
}