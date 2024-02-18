class BookAddress {
  final int? id;
  final String nickname;
  final String address;
  final String description;

  BookAddress({
    this.id,
    required this.nickname,
    required this.address,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nickname': nickname,
      'address': address,
      'description': description,
    };
  }

  BookAddress.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nickname = map['nickname'],
        address = map['address'],
        description = map['description'];

  BookAddress copyWith({
    int? id,
    String? nickname,
    String? address,
    String? description,
  }) =>
      BookAddress(
          id: id,
          nickname: nickname ?? this.nickname,
          address: address ?? this.address,
          description: description ?? this.description);
}