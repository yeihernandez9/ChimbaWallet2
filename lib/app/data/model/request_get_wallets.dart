class RequestGetAllWallets {
  final dynamic accounts;

  RequestGetAllWallets({this.accounts});

  factory RequestGetAllWallets.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("accounts") && json["accounts"].length > 0) {
      return RequestGetAllWallets(
        accounts: json["accounts"],
      );
    } else {
      return RequestGetAllWallets();
    }
  }
}
