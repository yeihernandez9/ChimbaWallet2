class RequestTokenFirebase{
   final dynamic response;

  RequestTokenFirebase({
    required this.response,
  });

  factory RequestTokenFirebase.fromJson(Map<String, dynamic> json) {
    return RequestTokenFirebase(
      response: json,
    );
  }
}