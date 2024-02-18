class RequestUnbonding {
  final String creation_height;
  final String completion_time;
  final String initial_balance;
  final String balance;

  RequestUnbonding(
      {this.creation_height = "0",
      this.completion_time = "0",
      this.initial_balance = "0",
      this.balance = "0"});

  factory RequestUnbonding.fromJson(Map<String, dynamic> json) =>
      RequestUnbonding(
        creation_height: json["creation_height"].toString(),
        completion_time: json["completion_time"].toString(),
        initial_balance: json["initial_balance"].toString(),
        balance: json["balance"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "creation_height": creation_height,
        "completion_time": completion_time,
        "initial_balance": initial_balance,
        "balance": balance
      };
}
