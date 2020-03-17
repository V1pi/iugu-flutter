import 'package:flutter_test/flutter_test.dart';
import 'package:iugu/utils.dart';

void main() {
  test('test validateAccountID', () {
    expect(IuguUtils.validateAccountID("F8F5CA88F1F64D91A488E94120501D61"), true);
    expect(IuguUtils.validateAccountID("F8F5CA88F1F64D91A420501D62"), false); 
  });

  test('test validateCreditCardNumber', () {
    expect(IuguUtils.validateCreditCardNumber("5495 9849 8848 9270"), true);
    expect(IuguUtils.validateCreditCardNumber("5191 3032 8817 2056"), false); 
  });
  test('test format UUID', () {
    expect(IuguUtils.formatUUID("884629730509465AA89387529A56EE3C"), "88462973-0509-465A-A893-87529A56EE3C");
  });

  test('test getBrandByCreditCardNumber', () {
    expect(IuguUtils.getBrandByCreditCardNumber("3010 818057 6543"), "diners");
    expect(IuguUtils.getBrandByCreditCardNumber("4716 2270 4394 0010"), "visa");
    expect(IuguUtils.getBrandByCreditCardNumber("5332 0147 3314 7945"), "mastercard");
  });
}
