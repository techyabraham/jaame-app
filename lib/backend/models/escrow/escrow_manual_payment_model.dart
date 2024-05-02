class EscrowManualPaymentModel {
  final Data data;

  EscrowManualPaymentModel({
    required this.data,
  });

  factory EscrowManualPaymentModel.fromJson(Map<String, dynamic> json) => EscrowManualPaymentModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final PaymentInformations paymentInformations;
  final List<InputField> inputFields;

  Data({
    required this.paymentInformations,
    required this.inputFields,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    paymentInformations: PaymentInformations.fromJson(json["payment_informations"]),
    inputFields: List<InputField>.from(json["input_fields"].map((x) => InputField.fromJson(x))),
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
    min: json["min"].toString(),
    options: List<dynamic>.from(json["options"].map((x) => x)),
    required: json["required"],
  );
}

class PaymentInformations {
  final String trx;

  PaymentInformations({
    required this.trx,
  });

  factory PaymentInformations.fromJson(Map<String, dynamic> json) => PaymentInformations(
    trx: json["trx"],
  );
}
