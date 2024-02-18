class ObserveVerifidWallet {
  final List<DataObject> data;

  ObserveVerifidWallet({required this.data});

  factory ObserveVerifidWallet.fromJson(List<dynamic> json) {
    List<DataObject> dataList =
        json.map((item) => DataObject.fromJson(item)).toList();
    return ObserveVerifidWallet(data: dataList);
  }
}

class DataObject {
  final String address;
  final bool validate;
  final int phoneNumber;

  DataObject({
    required this.address,
    required this.validate,
    required this.phoneNumber,
  });

  factory DataObject.fromJson(Map<String, dynamic> json) {
    return DataObject(
        address: json["address"],
        validate: json["Validate"],
        phoneNumber: json["phoneNumber"]);
  }
}
