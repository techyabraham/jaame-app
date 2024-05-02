
class CachedTatumModel {
  final Data data;

  CachedTatumModel({
    required this.data,
  });

  factory CachedTatumModel.fromJson(Map<String, dynamic> json) => CachedTatumModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final AddressInfo addressInfo;

  Data({
    required this.addressInfo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    addressInfo: AddressInfo.fromJson(json["address_info"]),
  );
}

class AddressInfo {
  final String coin;
  final String address;
  final List<InputField> inputFields;
  final String submitUrl;

  AddressInfo({
    required this.coin,
    required this.address,
    required this.inputFields,
    required this.submitUrl,
  });

  factory AddressInfo.fromJson(Map<String, dynamic> json) => AddressInfo(
    coin: json["coin"],
    address: json["address"],
    inputFields: List<InputField>.from(json["input_fields"].map((x) => InputField.fromJson(x))),
    submitUrl: json["submit_url"],
  );
}

class InputField {
  final String type;
  final String label;
  final String placeholder;
  final String name;
  final bool required;
  final Validation validation;

  InputField({
    required this.type,
    required this.label,
    required this.placeholder,
    required this.name,
    required this.required,
    required this.validation,
  });

  factory InputField.fromJson(Map<String, dynamic> json) => InputField(
    type: json["type"],
    label: json["label"],
    placeholder: json["placeholder"],
    name: json["name"],
    required: json["required"],
    validation: Validation.fromJson(json["validation"]),
  );
}

class Validation {
  final String min;
  final String max;
  final bool required;

  Validation({
    required this.min,
    required this.max,
    required this.required,
  });

  factory Validation.fromJson(Map<String, dynamic> json) => Validation(
    min: json["min"],
    max: json["max"],
    required: json["required"],
  );
}