/**
 * Types Option Vote
 * 4 :: No con derecho a veto
 * 1 :: Si
 * 3 :: No
 * 2 :: Abstenerse
 */
class RequestVoteByAddress {
  final String option;

  RequestVoteByAddress({
    this.option = "",
  });

  factory RequestVoteByAddress.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("error")) {
      return RequestVoteByAddress();
    } else {
      return RequestVoteByAddress(
        option: json["result"]["option"].toString(),
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "option": option,
      };
}
