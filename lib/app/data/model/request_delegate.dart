class RequestDelegate {
  final String denom;
  final String amount;

  RequestDelegate({
    this.denom = "CHIMBA",
    this.amount = "0",
  });

  factory RequestDelegate.fromJson(Map<String, dynamic> json) {
    if (json["result"].length > 0) {
      return RequestDelegate(
        denom: json["result"][0]["balance"]["denom"].toString(),
        amount: json["result"][0]["balance"]["amount"].toString(),
      );
    } else {
      return RequestDelegate();
    }
  }

  Map<String, dynamic> toJson() => {
        "denom": denom,
        "amount": amount,
      };
}
