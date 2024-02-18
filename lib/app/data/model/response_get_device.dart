class GetDevice {
  String? sId;
  String? oS;
  String? token;
  String? deviceID;
  int? date;
  int? iV;

  GetDevice({this.sId, this.oS, this.token, this.deviceID, this.date, this.iV});

  GetDevice.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    oS = json['OS'];
    token = json['Token'];
    deviceID = json['DeviceID'];
    date = json['Date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['OS'] = this.oS;
    data['Token'] = this.token;
    data['DeviceID'] = this.deviceID;
    data['Date'] = this.date;
    data['__v'] = this.iV;
    return data;
  }
}