import 'models.dart';

class IuguUtils {
  static bool validateAccountID(String accountID) {
    return RegExp(r"^[a-fA-F0-9]{8}[a-fA-F0-9]{4}[a-fA-F0-9]{4}[a-fA-F0-9]{4}[a-fA-F0-9]{12}$").hasMatch(accountID);
  }
  static bool validateCreditCardNumber(String creditCard) {
    if(creditCard.isNotEmpty && !RegExp(r"[^0-9-\s]+").hasMatch(creditCard)) {
      creditCard = creditCard.replaceAll(new RegExp(r"\D"), "");
      List<int> ints = new List(creditCard.length);
      for (int i = 0; i < creditCard.length; i++) {
        ints[i] = int.parse(creditCard.substring(i, i + 1));
      }

      for (int i = ints.length - 2; i >= 0; i = i - 2) {
        int j = ints[i];
        j = j * 2;
        if (j > 9) {
          j = j % 10 + 1;
        }
        ints[i] = j;
      }

      int sum = 0;
      for (int i = 0; i < ints.length; i++) {
        sum += ints[i];
      }

      return sum %10 ==0;    
    }
    return false;
  }

  static String formatUUID(String uuid) {
    String t = uuid.toUpperCase().replaceAll("-", "");
    return t.substring(0, 8) + "-" + t.substring(8, 12) + "-" + t.substring(12, 16) + "-" + t.substring(16, 20) + "-" + t.substring(20, 32);
  }

  static String getBrandByCreditCardNumber(String number) {
    number = number.replaceAll(r"[^0-9]", "");
    for (var card in cardsPattern) {
        if (card.brand.hasMatch(number)) {
          return card.name;
        }
    }
    return null;
  }

  static final List<IuguPatternCreditCard> cardsPattern = [
    new IuguPatternCreditCard("elo", r"^[0-9]{3}$", r"^(4011(78|79)|43(1274|8935)|45(1416|7393|763(1|2))|50(4175|6699|67[0-7][0-9]|9000)|50(9[0-9][0-9][0-9])|627780|63(6297|6368)|650(03([^4])|04([0-9])|05(0|1)|05([7-9])|06([0-9])|07([0-9])|08([0-9])|4([0-3][0-9]|8[5-9]|9[0-9])|5([0-9][0-9]|3[0-8])|9([0-6][0-9]|7[0-8])|7([0-2][0-9])|541|700|720|727|901)|65165([2-9])|6516([6-7][0-9])|65500([0-9])|6550([0-5][0-9])|655021|65505([6-7])|6516([8-9][0-9])|65170([0-4]))"),
    new IuguPatternCreditCard("visa", r"^[0-9]{3}$", r"^4"),
    new IuguPatternCreditCard("mastercard", r"^[0-9]{3}$", r"^(5[1-5]|677189|222[1-9]|22[3-9]|2[3-6]|27[01]|2720)"),
    new IuguPatternCreditCard("amex", r"^[0-9]{4}$", r"^(34|37)"),
    new IuguPatternCreditCard("diners", r"^[0-9]{3}$", r"^(30|36|38|39)")
  ];
}
