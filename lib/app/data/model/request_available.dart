class RequestAvailable {
  final String denom;
  final String amount;

  RequestAvailable({
    this.denom = "CHIMBA",
    this.amount = "0",
  });

  factory RequestAvailable.fromJson(Map<String, dynamic> json) {
    if (json["result"].length > 0) {
      return RequestAvailable(
        denom: json["result"][0]["denom"].toString(),
        amount: json["result"][0]["amount"].toString(),
      );
    } else {
      return RequestAvailable();
    }
  }

  Map<String, dynamic> toJson() => {
        "denom": denom,
        "amount": amount,
      };
}
