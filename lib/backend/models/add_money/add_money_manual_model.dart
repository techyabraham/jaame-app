import 'payment_information_model.dart';

class AddMoneyManualModel {
  final Data data;

  AddMoneyManualModel({
    required this.data,
  });

  factory AddMoneyManualModel.fromJson(Map<String, dynamic> json) => AddMoneyManualModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String gategayType;
  final String gatewayCurrencyName;
  final String alias;
  final String identify;
  final String details;
  final List<InputField> inputFields;
  final PaymentInformations paymentInformations;
  final String url;
  final String method;

  Data({
    required this.gategayType,
    required this.gatewayCurrencyName,
    required this.alias,
    required this.identify,
    required this.details,
    required this.inputFields,
    required this.paymentInformations,
    required this.url,
    required this.method,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    gategayType: json["gategay_type"],
    gatewayCurrencyName: json["gateway_currency_name"],
    alias: json["alias"],
    identify: json["identify"],
    details: json["details"],
    inputFields: List<InputField>.from(json["input_fields"].map((x) => InputField.fromJson(x))),
    paymentInformations: PaymentInformations.fromJson(json["payment_informations"]),
    url: json["url"],
    method: json["method"],
  );
}

class InputField {
  final String type;
  final String label;
  final String name;
  final bool required;
  final Validation validation;

  InputField({
    required this.type,
    required this.label,
    required this.name,
    required this.required,
    required this.validation,
  });

  factory InputField.fromJson(Map<String, dynamic> json) => InputField(
    type: json["type"],
    label: json["label"],
    name: json["name"],
    required: json["required"],
    validation: Validation.fromJson(json["validation"]),
  );
}

class Validation {
  final String max;
  final List<String> mimes;
  final dynamic min;
  final List<dynamic> options;
  final bool required;

  Validation({
    required this.max,
    required this.mimes,
    required this.min,
    required this.options,
    required this.required,
  });

  factory Validation.fromJson(Map<String, dynamic> json) => Validation(
    max: json["max"],
    mimes: List<String>.from(json["mimes"].map((x) => x)),
    min: json["min"],
    options: List<dynamic>.from(json["options"].map((x) => x)),
    required: json["required"],
  );
}