class Goods {
  GoodsData data;

  Goods({this.data});

  Goods.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GoodsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class GoodsData {
  List<Items> items;
  int pageNo;
  int pageSize;
  int totalCount;
  int totalPage;

  GoodsData(
      {this.items,
      this.pageNo,
      this.pageSize,
      this.totalCount,
      this.totalPage});

  GoodsData.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    pageNo = json['page_no'];
    pageSize = json['page_size'];
    totalCount = json['total_count'];
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['page_no'] = this.pageNo;
    data['page_size'] = this.pageSize;
    data['total_count'] = this.totalCount;
    data['total_page'] = this.totalPage;
    return data;
  }
}

class Items {
  ApproveStatus approveStatus;
  int brandId;
  String brandName;
  int catId;
  String changeProp;
  String created;
  String delistTime;
  Null detailUrl;
  int itemId;
  String itemNo;
  String listTime;
  String modified;
  int num;
  String outerItemId;
  int periodSoldQuantity;
  String picUrl;
  double price;
  String props;
  double retailPrice;
  String sellPoint;
  int soldQuantity;
  String title;
  TradeModel tradeModel;
  String type;
  int volume;
  bool selected;

  Items(
      {this.approveStatus,
      this.brandId,
      this.brandName,
      this.catId,
      this.changeProp,
      this.created,
      this.delistTime,
      this.detailUrl,
      this.itemId,
      this.itemNo,
      this.listTime,
      this.modified,
      this.num,
      this.outerItemId,
      this.periodSoldQuantity,
      this.picUrl,
      this.price,
      this.props,
      this.retailPrice,
      this.sellPoint,
      this.soldQuantity,
      this.title,
      this.tradeModel,
      this.type,
      this.volume,
      this.selected = false});

  Items.fromJson(Map<String, dynamic> json) {
    approveStatus = json['approve_status'] != null
        ? new ApproveStatus.fromJson(json['approve_status'])
        : null;
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    catId = json['cat_id'];
    changeProp = json['change_prop'];
    created = json['created'];
    delistTime = json['delist_time'];
    detailUrl = json['detail_url'];
    itemId = json['item_id'];
    itemNo = json['item_no'];
    listTime = json['list_time'];
    modified = json['modified'];
    num = json['num'];
    outerItemId = json['outer_item_id'];
    periodSoldQuantity = json['period_sold_quantity'];
    picUrl = json['pic_url'];
    price = json['price'];
    props = json['props'];
    retailPrice = json['retail_price'];
    sellPoint = json['sell_point'];
    soldQuantity = json['sold_quantity'];
    title = json['title'];
    tradeModel = json['trade_model'] != null
        ? new TradeModel.fromJson(json['trade_model'])
        : null;
    type = json['type'];
    volume = json['volume'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.approveStatus != null) {
      data['approve_status'] = this.approveStatus.toJson();
    }
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['cat_id'] = this.catId;
    data['change_prop'] = this.changeProp;
    data['created'] = this.created;
    data['delist_time'] = this.delistTime;
    data['detail_url'] = this.detailUrl;
    data['item_id'] = this.itemId;
    data['item_no'] = this.itemNo;
    data['list_time'] = this.listTime;
    data['modified'] = this.modified;
    data['num'] = this.num;
    data['outer_item_id'] = this.outerItemId;
    data['period_sold_quantity'] = this.periodSoldQuantity;
    data['pic_url'] = this.picUrl;
    data['price'] = this.price;
    data['props'] = this.props;
    data['retail_price'] = this.retailPrice;
    data['sell_point'] = this.sellPoint;
    data['sold_quantity'] = this.soldQuantity;
    data['title'] = this.title;
    if (this.tradeModel != null) {
      data['trade_model'] = this.tradeModel.toJson();
    }
    data['type'] = this.type;
    data['volume'] = this.volume;
    data['selected'] = this.selected || false;
    return data;
  }
}

class ApproveStatus {
  String key;
  String value;

  ApproveStatus({this.key, this.value});

  ApproveStatus.fromJson(Map<String, dynamic> json) {
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


class FreightPayer {
  String key;
  String value;

  FreightPayer({this.key, this.value});

  FreightPayer.fromJson(Map<String, dynamic> json) {
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

class Status {
  String key;
  String value;

  Status({this.key, this.value});

  Status.fromJson(Map<String, dynamic> json) {
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

class TradeModel {
  String key;
  String value;

  TradeModel({this.key, this.value});

  TradeModel.fromJson(Map<String, dynamic> json) {
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
