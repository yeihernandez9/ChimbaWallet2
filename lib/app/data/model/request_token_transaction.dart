class RequestTokenTransaction {
  final String token;

  RequestTokenTransaction({required this.token});

  factory RequestTokenTransaction.fromJson(Map<String, dynamic> json) {
    final token = json["token"] as String?;

    if (token != null) {
      return RequestTokenTransaction(token: token);
    } else {
      throw const FormatException("Invalid JSON structure");
    }
  }
}
