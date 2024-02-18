class UpdateTokenFirebase {
  String? oS;
  String? token;
  String? deviceID;

  UpdateTokenFirebase({this.oS, this.token, this.deviceID});

  UpdateTokenFirebase.fromJson(Map<String, dynamic> json) {
    oS = json['OS'];
    token = json['Token'];
    deviceID = json['DeviceID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OS'] = this.oS;
    data['Token'] = this.token;
    data['DeviceID'] = this.deviceID;
    return data;
  }
}