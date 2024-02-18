class UserWallet {
  final int? id;
  final String wallet;
  final String password;
  final String address;
  final String mnemonic;

  UserWallet({
    this.id,
    required this.wallet,
    required this.password,
    required this.address,
    required this.mnemonic,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'wallet': wallet,
      'password': password,
      'address': address,
      'mnemonic': mnemonic,
    };
  }

  UserWallet.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        wallet = map['wallet'],
        password = map['password'],
        address = map['address'],
        mnemonic = map['mnemonic'];

  UserWallet copyWith({
    int? id,
    String? wallet,
    String? password,
    String? address,
    String? mnemonic,
  }) =>
      UserWallet(
          id: id ?? this.id,
          wallet: wallet ?? this.wallet,
          password: password ?? this.password,
          address: address ?? this.address,
          mnemonic: mnemonic ?? this.mnemonic);

  isId() {
    return this.id != Null ? true : false;
  }
}
