class Message {
  MessageData? data;
  String? message;
  bool? status;

  Message({this.data, this.message, this.status});

  Message.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? MessageData.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class MessageData {
  String? secret;
  MessageData(
      {
      this.secret,
      });

  MessageData.fromJson(Map<String, dynamic> json) {
    secret = json['secret'];
   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['secret'] = secret;
    return data;
  }
}
