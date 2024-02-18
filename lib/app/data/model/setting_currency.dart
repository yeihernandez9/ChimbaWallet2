class SettingCurrency {
  final int? id;
  final String currency;
  final int status;
  final int price;

  SettingCurrency({
    this.id,
    required this.currency,
    required this.status,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'currency': currency,
      'status': status,
      'price': price,
    };
  }

  SettingCurrency.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        currency = map['currency'],
        status = map['status'],
        price = map['price'];

  SettingCurrency copyWith({
    int? id,
    String? currency,
    int? status,
    int? price,
  }) =>
      SettingCurrency(
          id: id,
          currency: currency ?? this.currency,
          status: status ?? this.status,
          price: price ?? this.price);
}
