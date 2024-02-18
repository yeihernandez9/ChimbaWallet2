class RequestCreateToken {
  final String token;
  RequestCreateToken({
    this.token = '',
  });

  factory RequestCreateToken.fromJson(Map<String, dynamic> json) {
    final user = json["user"] as Map<String, dynamic>?;

    if (user != null) {
      return RequestCreateToken(
        token: json["token"].toString(),
      );
    } else {
      return RequestCreateToken();
    }
  }
}
