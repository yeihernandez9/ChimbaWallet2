class RequestCodeValidate {
  final int otpCode;
  final int phoneNumber;

  RequestCodeValidate({
    required this.otpCode,
    required this.phoneNumber,
  });

  factory RequestCodeValidate.fromJson(Map<String, dynamic> json) {
    return RequestCodeValidate(
      otpCode: json["data"]["OTPCode"]["OTPCode"] as int,
      phoneNumber: int.parse(json["data"]["phoneNumber"]),
    );
  }
}
