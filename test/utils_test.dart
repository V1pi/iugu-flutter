import 'package:flutter_test/flutter_test.dart';
import 'package:iugu/utils.dart';

void main() {
  test('test validateAccountID', () {
    expect(validateAccountID("F8F5CA88F1F64D91A488E94120501D61"), true);
    expect(validateAccountID("F8F5CA88F1F64D91A420501D62"), false); 
  });

  test('test validateCreditCardNumber', () {
    expect(validateCreditCardNumber("5495 9849 8848 9270"), true);
    expect(validateCreditCardNumber("5191 3032 8817 2056"), false); 
  });
  test('test format UUID', () {
    expect(formatUUID("884629730509465AA89387529A56EE3C"), "88462973-0509-465A-A893-87529A56EE3C");
  });

  test('test getBrandByCreditCardNumber', () {
    expect(getBrandByCreditCardNumber("3010 818057 6543"), "diners");
    expect(getBrandByCreditCardNumber("4716 2270 4394 0010"), "visa");
    expect(getBrandByCreditCardNumber("5332 0147 3314 7945"), "mastercard");
  });
}
