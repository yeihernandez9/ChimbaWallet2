class ResendOpt {
  final bool send;

  ResendOpt(this.send);

  factory ResendOpt.fromJson(bool json) {
    return ResendOpt(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'send': send,
    };
  }
}
