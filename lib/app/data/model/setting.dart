class Setting {
  final int? id;
  final String name;
  final String value_status;
  final String description;

  Setting({
    this.id,
    required this.name,
    required this.value_status,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value_status': value_status,
      'description': description,
    };
  }

  Setting.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        value_status = map['value_status'],
        description = map['description'];

  Setting copyWith({
    int? id,
    String? name,
    String? value_status,
    String? description,
  }) =>
      Setting(
          id: id,
          name: name ?? this.name,
          value_status: value_status ?? this.value_status,
          description: description ?? this.description);
}
