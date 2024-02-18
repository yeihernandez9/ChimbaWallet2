/**
 * Types Option Vote
 * 4 :: No con derecho a veto
 * 1 :: Si
 * 3 :: No
 * 2 :: Abstenerse
 */
class RequestVote {
  final String option;

  RequestVote({
    this.option = "",
  });

  factory RequestVote.fromJson(Map<String, dynamic> json) {
    return RequestVote(
      option: json["options"][json["options"].length - 1]["option"].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "option": option,
      };
}
