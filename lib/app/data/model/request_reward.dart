class RequestReward {
  final String denom;
  final String amount;

  RequestReward({
    this.denom = "CHIMBA",
    this.amount = "0",
  });

  factory RequestReward.fromJson(Map<String, dynamic> json) {
    if (json["result"]["total"].length > 0) {
      return RequestReward(
        denom: json["result"]["total"][0]["denom"].toString(),
        amount: json["result"]["total"][0]["amount"].toString(),
      );
    } else {
      return RequestReward();
    }
  }

  Map<String, dynamic> toJson() => {
        "denom": denom,
        "amount": amount,
      };
}
