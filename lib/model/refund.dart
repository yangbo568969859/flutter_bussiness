class Refund {
  RefundData data;

  Refund({this.data});

  Refund.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new RefundData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class RefundData {
  int pageNo;
  int pageSize;
  List<Refunds> refunds;
  int totalCount;
  int totalPage;

  RefundData(
      {this.pageNo,
      this.pageSize,
      this.refunds,
      this.totalCount,
      this.totalPage});

  RefundData.fromJson(Map<String, dynamic> json) {
    pageNo = json['page_no'];
    pageSize = json['page_size'];
    if (json['refunds'] != null) {
      refunds = new List<Refunds>();
      json['refunds'].forEach((v) {
        refunds.add(new Refunds.fromJson(v));
      });
    }
    totalCount = json['total_count'];
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_no'] = this.pageNo;
    data['page_size'] = this.pageSize;
    if (this.refunds != null) {
      data['refunds'] = this.refunds.map((v) => v.toJson()).toList();
    }
    data['total_count'] = this.totalCount;
    data['total_page'] = this.totalPage;
    return data;
  }
}

class Refunds {
  int buyerId;
  String buyerNick;
  String created;
  int itemId;
  int orderId;
  OrderStatus orderStatus;
  String picUrl;
  double price;
  String propertiesName;
  int refundId;
  RefundStatus refundStatus;
  RefundType refundType;
  int sellerId;
  String sellerNick;
  String title;

  Refunds(
      {this.buyerId,
      this.buyerNick,
      this.created,
      this.itemId,
      this.orderId,
      this.orderStatus,
      this.picUrl,
      this.price,
      this.propertiesName,
      this.refundId,
      this.refundStatus,
      this.refundType,
      this.sellerId,
      this.sellerNick,
      this.title});

  Refunds.fromJson(Map<String, dynamic> json) {
    buyerId = json['buyer_id'];
    buyerNick = json['buyer_nick'];
    created = json['created'];
    itemId = json['item_id'];
    orderId = json['order_id'];
    orderStatus = json['order_status'] != null
        ? new OrderStatus.fromJson(json['order_status'])
        : null;
    picUrl = json['pic_url'];
    price = json['price'];
    propertiesName = json['properties_name'];
    refundId = json['refund_id'];
    refundStatus = json['refund_status'] != null
        ? new RefundStatus.fromJson(json['refund_status'])
        : null;
    refundType = json['refund_type'] != null
        ? new RefundType.fromJson(json['refund_type'])
        : null;
    sellerId = json['seller_id'];
    sellerNick = json['seller_nick'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buyer_id'] = this.buyerId;
    data['buyer_nick'] = this.buyerNick;
    data['created'] = this.created;
    data['item_id'] = this.itemId;
    data['order_id'] = this.orderId;
    if (this.orderStatus != null) {
      data['order_status'] = this.orderStatus.toJson();
    }
    data['pic_url'] = this.picUrl;
    data['price'] = this.price;
    data['properties_name'] = this.propertiesName;
    data['refund_id'] = this.refundId;
    if (this.refundStatus != null) {
      data['refund_status'] = this.refundStatus.toJson();
    }
    if (this.refundType != null) {
      data['refund_type'] = this.refundType.toJson();
    }
    data['seller_id'] = this.sellerId;
    data['seller_nick'] = this.sellerNick;
    data['title'] = this.title;
    return data;
  }
}

class OrderStatus {
  String key;
  String value;

  OrderStatus({this.key, this.value});

  OrderStatus.fromJson(Map<String, dynamic> json) {
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

class RefundStatus {
  String key;
  String value;

  RefundStatus({this.key, this.value});

  RefundStatus.fromJson(Map<String, dynamic> json) {
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

class RefundType {
  String key;
  String value;

  RefundType({this.key, this.value});

  RefundType.fromJson(Map<String, dynamic> json) {
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
