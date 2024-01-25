class StoreTemplate {
  StoreTemplateData data;

  StoreTemplate({this.data});

  StoreTemplate.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new StoreTemplateData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class StoreTemplateData {
  int code;
  StoreTemplateList data;
  bool isSuccess;
  String message;
  Null subCode;
  Null subMsg;

  StoreTemplateData(
      {this.code,
      this.data,
      this.isSuccess,
      this.message,
      this.subCode,
      this.subMsg});

  StoreTemplateData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new StoreTemplateList.fromJson(json['data']) : null;
    isSuccess = json['is_success'];
    message = json['message'];
    subCode = json['sub_code'];
    subMsg = json['sub_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['is_success'] = this.isSuccess;
    data['message'] = this.message;
    data['sub_code'] = this.subCode;
    data['sub_msg'] = this.subMsg;
    return data;
  }
}

class StoreTemplateList {
  List<StoreTemplateItem> data;
  int pageNo;
  int pageSize;
  int total;
  int totalPage;

  StoreTemplateList({this.data, this.pageNo, this.pageSize, this.total, this.totalPage});

  StoreTemplateList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<StoreTemplateItem>();
      json['data'].forEach((v) {
        data.add(new StoreTemplateItem.fromJson(v));
      });
    }
    pageNo = json['page_no'];
    pageSize = json['page_size'];
    total = json['total'];
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['page_no'] = this.pageNo;
    data['page_size'] = this.pageSize;
    data['total'] = this.total;
    data['total_page'] = this.totalPage;
    return data;
  }
}

class StoreTemplateItem {
  String bgImg;
  String conditions;
  int shopThemeTemplateId;
  int status;
  String themeImg;
  String title;
  String type;
  String version;

  StoreTemplateItem(
      {this.bgImg,
      this.conditions,
      this.shopThemeTemplateId,
      this.status,
      this.themeImg,
      this.title,
      this.type,
      this.version});

  StoreTemplateItem.fromJson(Map<String, dynamic> json) {
    bgImg = json['bg_img'];
    conditions = json['conditions'];
    shopThemeTemplateId = json['shop_theme_template_id'];
    status = json['status'];
    themeImg = json['theme_img'];
    title = json['title'];
    type = json['type'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bg_img'] = this.bgImg;
    data['conditions'] = this.conditions;
    data['shop_theme_template_id'] = this.shopThemeTemplateId;
    data['status'] = this.status;
    data['theme_img'] = this.themeImg;
    data['title'] = this.title;
    data['type'] = this.type;
    data['version'] = this.version;
    return data;
  }
}



class ShopTheme {
  ShopThemeData data;

  ShopTheme({this.data});

  ShopTheme.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ShopThemeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ShopThemeData {
  int code;
  ShopThemeItem data;
  bool isSuccess;
  String message;
  Null subCode;
  Null subMsg;

  ShopThemeData(
      {this.code,
      this.data,
      this.isSuccess,
      this.message,
      this.subCode,
      this.subMsg});

  ShopThemeData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new ShopThemeItem.fromJson(json['data']) : null;
    isSuccess = json['is_success'];
    message = json['message'];
    subCode = json['sub_code'];
    subMsg = json['sub_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['is_success'] = this.isSuccess;
    data['message'] = this.message;
    data['sub_code'] = this.subCode;
    data['sub_msg'] = this.subMsg;
    return data;
  }
}

class ShopThemeItem {
  BusinessData businessData;
  int shopId;
  int shopThemeId;
  int shopThemeTemplateId;
  String shopThemeTemplateType;
  int status;
  Null userId;

  ShopThemeItem(
      {this.businessData,
      this.shopId,
      this.shopThemeId,
      this.shopThemeTemplateId,
      this.shopThemeTemplateType,
      this.status,
      this.userId});

  ShopThemeItem.fromJson(Map<String, dynamic> json) {
    businessData = json['business_data'] != null
        ? new BusinessData.fromJson(json['business_data'])
        : null;
    shopId = json['shop_id'];
    shopThemeId = json['shop_theme_id'];
    shopThemeTemplateId = json['shop_theme_template_id'];
    shopThemeTemplateType = json['shop_theme_template_type'];
    status = json['status'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.businessData != null) {
      data['business_data'] = this.businessData.toJson();
    }
    data['shop_id'] = this.shopId;
    data['shop_theme_id'] = this.shopThemeId;
    data['shop_theme_template_id'] = this.shopThemeTemplateId;
    data['shop_theme_template_type'] = this.shopThemeTemplateType;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    return data;
  }
}

class BusinessData {
  String bgImg;

  BusinessData({this.bgImg});

  BusinessData.fromJson(Map<String, dynamic> json) {
    bgImg = json['bg_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bg_img'] = this.bgImg;
    return data;
  }
}
