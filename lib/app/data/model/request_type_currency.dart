class RequestTypeMoney {
  final String amount;
  final String source;
  final String target;

  RequestTypeMoney({this.amount = "0", this.source = '', this.target = ''});

  factory RequestTypeMoney.fromJson(Map<String, dynamic> json) {
    if (json["status"] == 'OK') {
      return RequestTypeMoney(
        amount: json["result"]["amount"].toString(),
        source: json["result"]["source"].toString(),
        target: json["result"]["target"].toString(),
      );
    } else {
      return RequestTypeMoney();
    }
  }
}
