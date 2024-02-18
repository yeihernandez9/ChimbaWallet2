class RequestTransaction {
  final dynamic response;

  RequestTransaction({
    required this.response,
  });

  factory RequestTransaction.fromJson(Map<String, dynamic> json) {
    return RequestTransaction(
      response: json,
    );
  }
}
