class CreateVerifidWallet {
  final String phonePrefix;
  final int phoneNumber;
  final String address;

  CreateVerifidWallet({
    required this.phonePrefix,
    required this.phoneNumber,
    required this.address,
  });

  factory CreateVerifidWallet.fromJson(Map<String, dynamic> json) {
    return CreateVerifidWallet(
      phonePrefix: json['phonePrefix'] as String,
      phoneNumber: json['phoneNumber'] as int,
      address: json['address'] as String,
    );
  }
}
