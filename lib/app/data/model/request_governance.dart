import 'package:meta/meta.dart' show required;

class RequestGovernance {
  final String? id;
  final Content? content;
  final int? status;
  final FinalTallyResult? finalTallyResult;
  final String? submitTime;
  final String? depositEndTime;
  final List<String>? totalDeposit;
  final DateTime? votingStartTime;
  final DateTime? votingEndTime;

  RequestGovernance(
      {@required this.id,
      @required this.content,
      @required this.status,
      @required this.finalTallyResult,
      @required this.submitTime,
      @required this.depositEndTime,
      @required this.totalDeposit,
      @required this.votingStartTime,
      @required this.votingEndTime});

  factory RequestGovernance.fromJson(Map<String, dynamic> json) =>
      RequestGovernance(
          id: json['id'].toString(),
          content: json['content'] != null
              ? new Content.fromJson(json['content'])
              : null,
          status: json['status'],
          finalTallyResult: json['final_tally_result'] != null
              ? new FinalTallyResult.fromJson(json['final_tally_result'])
              : null,
          submitTime: json['submit_time'].toString(),
          depositEndTime: json['deposit_end_time'].toString(),
          totalDeposit: [],
          votingEndTime: DateTime.parse(json["voting_end_time"]),
          votingStartTime: DateTime.parse(json['voting_start_time']));

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "status": status,
        "final_tally_result": finalTallyResult,
        "submitTime": submitTime,
        "depositEndTime": depositEndTime,
        "totalDeposit": totalDeposit,
        "votingEndTime": votingEndTime,
        "votingStartTime": votingStartTime
      };
}

class Content {
  final String? type;
  final Value? value;

  Content({required this.type, required this.value});

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        type: json["type"].toString(),
        value: json['value'] != null ? new Value.fromJson(json['value']) : null,
      );

  Map<String, dynamic> toJson() => {"type": type, "value": value};
}

class Value {
  final String? title;
  final String? description;
  final String? recipient;
  final List<String>? amount;

  Value(
      {required this.title,
      required this.description,
      required this.recipient,
      required this.amount});

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        amount: [],
        description: json["description"].toString(),
        recipient: json["recipient"].toString(),
        title: json["title"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "recipient": recipient,
        "amount": amount
      };
}

class FinalTallyResult {
  final String yes;
  final String abstain;
  final String no;
  final String noWithVeto;

  FinalTallyResult(
      {required this.yes,
      required this.abstain,
      required this.no,
      required this.noWithVeto});

  factory FinalTallyResult.fromJson(Map<String, dynamic> json) =>
      FinalTallyResult(
          abstain: json["abstain"] ?? '0',
          no: json["no"] ?? '0',
          noWithVeto: json["noWithVeto"] ?? '0',
          yes: json["yes"] ?? '0');

  Map<String, dynamic> toJson() =>
      {"yes": yes, "abstain": abstain, "no": no, "no_with_veto": noWithVeto};
}
