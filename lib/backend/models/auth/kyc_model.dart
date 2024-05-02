class KycModel {
  final Data data;

  KycModel({
    required this.data,
  });

  factory KycModel.fromJson(Map<String, dynamic> json) => KycModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final int kycStatus;
  final List<InputField> inputFields;

  Data({
    required this.kycStatus,
    required this.inputFields,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    kycStatus: json["kyc_status"],
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
  // final dynamic max;
  final List<String> mimes;
  // final dynamic min;
  final List<String> options;
  final bool required;

  Validation({
    // required this.max,
    required this.mimes,
    // required this.min,
    required this.options,
    required this.required,
  });

  factory Validation.fromJson(Map<String, dynamic> json) => Validation(
    // max: int.parse(json["max"] ?? "0"),
    mimes: List<String>.from(json["mimes"].map((x) => x)),
    // min: int.parse(json["min"] ?? "0"),
    options: List<String>.from(json["options"].map((x) => x)),
    required: json["required"],
  );
}