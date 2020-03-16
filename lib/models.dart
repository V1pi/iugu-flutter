import 'package:flutter/material.dart';

class Token {
    String id;
    String accountId;
    String method = "credit_card";
    bool test;
    CreditCard creditCard;

    Token({
        this.id,
        @required
        this.accountId,
        this.test = true,
        @required
        this.creditCard,
    });

    factory Token.fromJson(Map<String, dynamic> json) => Token(
        id: json["id"],
        test: json["test"],
        creditCard: CreditCard.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "account_id": accountId,
        "method": method,
        "test": test,
        "data": creditCard.toJson(),
    };
}

class CreditCard {
    String number;
    int verificationValue;
    String firstName;
    String lastName;
    int month;
    int year;
    String brand;
    String holderName;
    String displayNumber;
    String bin;

    CreditCard({
        @required
        this.number,
        @required
        this.verificationValue,
        @required
        this.firstName,
        @required
        this.lastName,
        @required
        this.month,
        @required
        this.year,
        this.brand,
        this.holderName,
        this.displayNumber,
        this.bin,
    });

    factory CreditCard.fromJson(Map<String, dynamic> json) => CreditCard(
        number: json["number"],
        verificationValue: json["verification_value"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        month: json["month"],
        year: json["year"],
        brand: json["brand"],
        holderName: json["holder_name"],
        displayNumber: json["display_number"],
        bin: json["bin"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "verification_value": verificationValue,
        "first_name": firstName,
        "last_name": lastName,
        "month": month,
        "year": year
    };
}

class PatternCreditCard {
  RegExp cvv, brand;
  String name;

  PatternCreditCard(String name, String cvv, String brand) {
    this.name = name;
    this.cvv = new RegExp(cvv);
    this.brand = new RegExp(brand);
  }
}