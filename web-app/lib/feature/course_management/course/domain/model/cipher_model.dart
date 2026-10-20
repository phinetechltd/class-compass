class CipherModel {
  String? message;
  Data? data;

  CipherModel({this.message, this.data});

  CipherModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] is Map ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? otp;
  String? playbackInfo;

  Data({this.otp, this.playbackInfo});

  Data.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    playbackInfo = json['playbackInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otp'] = otp;
    data['playbackInfo'] = playbackInfo;
    return data;
  }
}
