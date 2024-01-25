class UploadImage {
  UploadImageData data;

  UploadImage({this.data});

  UploadImage.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new UploadImageData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class UploadImageData {
  bool isSuccess;
  String msg;
  String picUrl;

  UploadImageData({this.isSuccess, this.msg, this.picUrl});

  UploadImageData.fromJson(Map<String, dynamic> json) {
    isSuccess = json['is_success'];
    msg = json['msg'];
    picUrl = json['pic_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_success'] = this.isSuccess;
    data['msg'] = this.msg;
    data['pic_url'] = this.picUrl;
    return data;
  }
}