class Address {
  AddressData data;

  Address({this.data});

  Address.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new AddressData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class AddressData {
  List<Addresses> addresses;

  AddressData({this.addresses});

  AddressData.fromJson(Map<String, dynamic> json) {
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  String address;
  int addressId;
  AddressType addressType;
  String city;
  String company;
  String contactName;
  String country;
  String created;
  String district;
  bool isDef;
  String mobile;
  String modified;
  String phone;
  int regionId;
  String state;
  String town;
  int userId;
  String zip;

  Addresses(
      {this.address,
      this.addressId,
      this.addressType,
      this.city,
      this.company,
      this.contactName,
      this.country,
      this.created,
      this.district,
      this.isDef,
      this.mobile,
      this.modified,
      this.phone,
      this.regionId,
      this.state,
      this.town,
      this.userId,
      this.zip});

  Addresses.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    addressId = json['address_id'];
    addressType = json['address_type'] != null
        ? new AddressType.fromJson(json['address_type'])
        : null;
    city = json['city'];
    company = json['company'];
    contactName = json['contact_name'];
    country = json['country'];
    created = json['created'];
    district = json['district'];
    isDef = json['is_def'];
    mobile = json['mobile'];
    modified = json['modified'];
    phone = json['phone'];
    regionId = json['region_id'];
    state = json['state'];
    town = json['town'];
    userId = json['user_id'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['address_id'] = this.addressId;
    if (this.addressType != null) {
      data['address_type'] = this.addressType.toJson();
    }
    data['city'] = this.city;
    data['company'] = this.company;
    data['contact_name'] = this.contactName;
    data['country'] = this.country;
    data['created'] = this.created;
    data['district'] = this.district;
    data['is_def'] = this.isDef;
    data['mobile'] = this.mobile;
    data['modified'] = this.modified;
    data['phone'] = this.phone;
    data['region_id'] = this.regionId;
    data['state'] = this.state;
    data['town'] = this.town;
    data['user_id'] = this.userId;
    data['zip'] = this.zip;
    return data;
  }
}

class AddressType {
  String key;
  String value;

  AddressType({this.key, this.value});

  AddressType.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}


class AddressDetailModel {
  AddressDetailDataModel data;

  AddressDetailModel({this.data});

  AddressDetailModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new AddressDetailDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class AddressDataList {
  String address;
  int addressId;
  int certifyId;
  String city;
  String contactName;
  String country;
  String district;
  bool hasBindCertify;
  String identityId;
  bool isDefault;
  String mobile;
  String state;
  String town;

  AddressDataList(
      {this.address,
      this.addressId,
      this.certifyId,
      this.city,
      this.contactName,
      this.country,
      this.district,
      this.hasBindCertify,
      this.identityId,
      this.isDefault,
      this.mobile,
      this.state,
      this.town});

  AddressDataList.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    addressId = json['address_id'];
    certifyId = json['certify_id'];
    city = json['city'];
    contactName = json['contact_name'];
    country = json['country'];
    district = json['district'];
    hasBindCertify = json['has_bind_certify'];
    identityId = json['identity_id'];
    isDefault = json['is_default'];
    mobile = json['mobile'];
    state = json['state'];
    town = json['town'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['address_id'] = this.addressId;
    data['certify_id'] = this.certifyId;
    data['city'] = this.city;
    data['contact_name'] = this.contactName;
    data['country'] = this.country;
    data['district'] = this.district;
    data['has_bind_certify'] = this.hasBindCertify;
    data['identity_id'] = this.identityId;
    data['is_default'] = this.isDefault;
    data['mobile'] = this.mobile;
    data['state'] = this.state;
    data['town'] = this.town;
    return data;
  }
}

class AddressDetailDataModel {
  int code;
  AddressDataList data;
  String message;
  Null subCode;
  Null subMsg;
  bool success;

  AddressDetailDataModel(
      {this.code,
      this.data,
      this.message,
      this.subCode,
      this.subMsg,
      this.success});

  AddressDetailDataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new AddressDataList.fromJson(json['data']) : null;
    message = json['message'];
    subCode = json['sub_code'];
    subMsg = json['sub_msg'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['sub_code'] = this.subCode;
    data['sub_msg'] = this.subMsg;
    data['success'] = this.success;
    return data;
  }
}