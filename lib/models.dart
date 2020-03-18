import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IuguToken {
    String id;
    String accountId;
    String method = "credit_card";
    bool test;
    IuguCreditCard creditCard;

    IuguToken({
        this.id,
        @required
        this.accountId,
        this.test = true,
        @required
        this.creditCard,
        this.method
    });

    factory IuguToken.fromJson(Map<String, dynamic> json) => IuguToken(
        accountId: null,
        id: json["id"],
        test: json["test"],
        method: json["method"],
        creditCard: json["data"] == null ? IuguCreditCard.fromJson(json["extra_info"]) : IuguCreditCard.fromJson(json["data"])
    );

    Map<String, dynamic> toJson() => {
        "account_id": accountId,
        "method": method,
        "test": test,
        "id": id,
        "data": creditCard.toJson(),
    };
  int get hashCode => id.hashCode^accountId.hashCode^method.hashCode^
                      test.hashCode^creditCard.hashCode;
  bool operator== (o) => o is IuguToken && o.id == id && o.accountId == accountId &&
                        o.method == method && o.test == test && o.creditCard == creditCard;
}

class IuguPaymentMethod {
  String id;
  String itemType;
  String description;
  IuguClient client;
  IuguCreditCard creditCard;

  IuguPaymentMethod({
      this.id,
      this.client,
      this.creditCard,
      this.itemType,
      this.description,
  });

  factory IuguPaymentMethod.fromJson(Map<String, dynamic> json) => IuguPaymentMethod(
      id: json["id"],
      creditCard: IuguCreditCard.fromJson(json["data"]),
      itemType: json["item_type"],
      description: json["description"],
      client: new IuguClient(id: json["customer_id"])
  );

    Map<String, dynamic> toJson() => {
      "id": id,
      "data": creditCard.toJson(),
      "item_type": itemType,
      "description": description,
      "customer_id": client.id
  };

  int get hashCode => id.hashCode^itemType.hashCode^description.hashCode^client.hashCode^creditCard.hashCode;
  bool operator== (o) => o is IuguPaymentMethod && o.id == id && o.itemType == itemType && o.description == description &&
                        o.client == client && o.creditCard == creditCard;
}

class IuguCreditCard {
    String id;
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

    IuguCreditCard({
        this.id,
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

    factory IuguCreditCard.fromJson(Map<String, dynamic> json) => IuguCreditCard(
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

    int get hashCode => number.hashCode^verificationValue.hashCode^firstName.hashCode^lastName.hashCode
                        ^month.hashCode^year.hashCode^brand.hashCode^holderName.hashCode^displayNumber.hashCode
                        ^bin.hashCode^id.hashCode;
    bool operator== (o) => o is IuguCreditCard && o.number == number && o.verificationValue == verificationValue && 
                          o.firstName == firstName && o.lastName == lastName && o.month == month && o.year == year &&
                          o.brand == brand && o.holderName == holderName && o.displayNumber == displayNumber &&
                          o.bin == bin && o.id == id;
}


class IuguClient {
    String id;
    String email;
    String name;
    String notes;
    int phone;
    int phonePrefix;
    String cpfCnpj;
    String ccEmails;
    String zipCode;
    String number;
    String street;
    String city;
    String state;
    String district;
    String complement;
    List<dynamic> customVariables;
    DateTime createdAt;
    DateTime updatedAt;

    IuguClient({
        this.id,
        this.email,
        this.name,
        this.notes,
        this.phone,
        this.phonePrefix,
        this.cpfCnpj,
        this.ccEmails,
        this.zipCode,
        this.number,
        this.street,
        this.city,
        this.state,
        this.district,
        this.complement,
        this.customVariables,
        this.createdAt,
        this.updatedAt,
    });

    factory IuguClient.fromJson(Map<String, dynamic> json) => IuguClient(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        notes: json["notes"],
        phone: json["phone"],
        phonePrefix: json["phone_prefix"],
        cpfCnpj: json["cpf_cnpj"],
        ccEmails: json["cc_emails"],
        zipCode: json["zip_code"],
        number: json["number"],
        street: json["street"],
        city: json["city"],
        state: json["state"],
        district: json["district"],
        complement: json["complement"],
        customVariables:  List<dynamic>.from(json["custom_variables"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "notes": notes,
        "phone": phone,
        "phone_prefix": phonePrefix,
        "cpf_cnpj": cpfCnpj,
        "cc_emails": ccEmails,
        "zip_code": zipCode,
        "number": number,
        "street": street,
        "city": city,
        "state": state,
        "district": district,
        "complement": complement,
        "custom_variables": customVariables != null ? List<dynamic>.from(customVariables.map((x) => x)) : [],
        "created_at": createdAt != null ? createdAt.toIso8601String() : null,
        "updated_at": updatedAt != null ? updatedAt.toIso8601String() : null,
    };

    int get hashCode => id.hashCode^email.hashCode^name.hashCode^notes.hashCode^phone.hashCode
                        ^phonePrefix.hashCode^cpfCnpj.hashCode^ccEmails.hashCode^zipCode.hashCode
                        ^number.hashCode
                        ^street.hashCode^city.hashCode^state.hashCode^district.hashCode^complement.hashCode
                        ^hashList(customVariables)^createdAt.hashCode^updatedAt.hashCode;
    bool operator== (o) => o is IuguClient && o.email == email && o.name == name && o.id == id &&
                          o.notes == notes && o.phone == phone && o.phonePrefix == phonePrefix 
                          && o.cpfCnpj == cpfCnpj && o.ccEmails == ccEmails && o.zipCode == zipCode &&
                          o.number == number && o.street == street && o.city == city &&
                          o.state == state && o.district == district &&
                          o.complement == complement && listEquals(o.customVariables, customVariables) &&
                          o.createdAt == createdAt && o.updatedAt == updatedAt;
}


class IuguPatternCreditCard {
  RegExp cvv, brand;
  String name;

  IuguPatternCreditCard(String name, String cvv, String brand) {
    this.name = name;
    this.cvv = new RegExp(cvv);
    this.brand = new RegExp(brand);
  }
}