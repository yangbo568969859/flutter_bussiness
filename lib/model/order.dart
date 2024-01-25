class Order {
  OrderData data;

  Order({this.data});

  Order.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new OrderData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class OrderData {
  int pageNo;
  int pageSize;
  int totalCount;
  int totalPage;
  List<Trades> trades;

  OrderData(
      {this.pageNo,
      this.pageSize,
      this.totalCount,
      this.totalPage,
      this.trades});

  OrderData.fromJson(Map<String, dynamic> json) {
    pageNo = json['page_no'];
    pageSize = json['page_size'];
    totalCount = json['total_count'];
    totalPage = json['total_page'];
    if (json['trades'] != null) {
      trades = new List<Trades>();
      json['trades'].forEach((v) {
        trades.add(new Trades.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_no'] = this.pageNo;
    data['page_size'] = this.pageSize;
    data['total_count'] = this.totalCount;
    data['total_page'] = this.totalPage;
    if (this.trades != null) {
      data['trades'] = this.trades.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Trades {
  double adjustFee;
  String created;
  Null identityId;
  String memo;
  int num;
  List<Orders> orders;
  Null outerTradeId;
  double payment;
  double postFee;
  String remark;
  int sellerId;
  String sellerNick;
  Status status;
  double taxFee;
  double totalFee;
  int tradeId;
  TradeModel tradeModel;
  Null tradeOperate;

  Trades(
      {this.adjustFee,
      this.created,
      this.identityId,
      this.memo,
      this.num,
      this.orders,
      this.outerTradeId,
      this.payment,
      this.postFee,
      this.remark,
      this.sellerId,
      this.sellerNick,
      this.status,
      this.taxFee,
      this.totalFee,
      this.tradeId,
      this.tradeModel,
      this.tradeOperate});

  Trades.fromJson(Map<String, dynamic> json) {
    adjustFee = json['adjust_fee'];
    created = json['created'];
    identityId = json['identity_id'];
    memo = json['memo'];
    num = json['num'];
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
    outerTradeId = json['outer_trade_id'];
    payment = json['payment'];
    postFee = json['post_fee'];
    remark = json['remark'];
    sellerId = json['seller_id'];
    sellerNick = json['seller_nick'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    taxFee = json['tax_fee'];
    totalFee = json['total_fee'];
    tradeId = json['trade_id'];
    tradeModel = json['trade_model'] != null
        ? new TradeModel.fromJson(json['trade_model'])
        : null;
    tradeOperate = json['trade_operate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adjust_fee'] = this.adjustFee;
    data['created'] = this.created;
    data['identity_id'] = this.identityId;
    data['memo'] = this.memo;
    data['num'] = this.num;
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    data['outer_trade_id'] = this.outerTradeId;
    data['payment'] = this.payment;
    data['post_fee'] = this.postFee;
    data['remark'] = this.remark;
    data['seller_id'] = this.sellerId;
    data['seller_nick'] = this.sellerNick;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['tax_fee'] = this.taxFee;
    data['total_fee'] = this.totalFee;
    data['trade_id'] = this.tradeId;
    if (this.tradeModel != null) {
      data['trade_model'] = this.tradeModel.toJson();
    }
    data['trade_operate'] = this.tradeOperate;
    return data;
  }
}

class Orders {
  int itemId;
  int num;
  int orderId;
  Null outSkuId;
  String picUrl;
  double price;
  String propertiesName;
  RefundStatus refundStatus;
  int skuId;
  Status status;
  double taxFee;
  String title;

  Orders(
      {this.itemId,
      this.num,
      this.orderId,
      this.outSkuId,
      this.picUrl,
      this.price,
      this.propertiesName,
      this.refundStatus,
      this.skuId,
      this.status,
      this.taxFee,
      this.title});

  Orders.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    num = json['num'];
    orderId = json['order_id'];
    outSkuId = json['out_sku_id'];
    picUrl = json['pic_url'];
    price = json['price'];
    propertiesName = json['properties_name'];
    refundStatus = json['refund_status'] != null
        ? new RefundStatus.fromJson(json['refund_status'])
        : null;
    skuId = json['sku_id'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    taxFee = json['tax_fee'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['num'] = this.num;
    data['order_id'] = this.orderId;
    data['out_sku_id'] = this.outSkuId;
    data['pic_url'] = this.picUrl;
    data['price'] = this.price;
    data['properties_name'] = this.propertiesName;
    if (this.refundStatus != null) {
      data['refund_status'] = this.refundStatus.toJson();
    }
    data['sku_id'] = this.skuId;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['tax_fee'] = this.taxFee;
    data['title'] = this.title;
    return data;
  }
}



class OrderDetails {
  OrderDetailData data;

  OrderDetails({this.data});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new OrderDetailData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class OrderDetailData {
  Trade trade;

  OrderDetailData({this.trade});

  OrderDetailData.fromJson(Map<String, dynamic> json) {
    trade = json['trade'] != null ? new Trade.fromJson(json['trade']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.trade != null) {
      data['trade'] = this.trade.toJson();
    }
    return data;
  }
}

class Trade {
  double adjustFee;
  String consignTime;
  Null contact;
  String created;
  int distributorId;
  String endTime;
  bool isBought;
  String markDesc;
  String memo;
  Null orderTimeout;
  List<OrdersD> orders;
  bool ownDelivery;
  String payNo;
  String payTime;
  double payTimeoutMs;
  PayType payType;
  double payment;
  double postFee;
  List<Promotions> promotions;
  double purchaseAmount;
  double receivedPayment;
  int sellerId;
  String sellerNick;
  ShippingAddress shippingAddress;
  Status status;
  Null storeName;
  double taxFee;
  double totalFee;
  int tradeId;
  TradeModel tradeModel;
  String tradeOperate;
  String remark;

  Trade(
      {this.adjustFee,
      this.consignTime,
      this.contact,
      this.created,
      this.distributorId,
      this.endTime,
      this.isBought,
      this.markDesc,
      this.memo,
      this.orderTimeout,
      this.orders,
      this.ownDelivery,
      this.payNo,
      this.payTime,
      this.payTimeoutMs,
      this.payType,
      this.payment,
      this.postFee,
      this.promotions,
      this.purchaseAmount,
      this.receivedPayment,
      this.sellerId,
      this.sellerNick,
      this.shippingAddress,
      this.status,
      this.storeName,
      this.taxFee,
      this.totalFee,
      this.tradeId,
      this.tradeModel,
      this.tradeOperate,
      this.remark});

  Trade.fromJson(Map<String, dynamic> json) {
    adjustFee = json['adjust_fee'];
    consignTime = json['consign_time'];
    contact = json['contact'];
    created = json['created'];
    distributorId = json['distributor_id'];
    endTime = json['end_time'];
    isBought = json['is_bought'];
    markDesc = json['mark_desc'];
    memo = json['memo'];
    orderTimeout = json['order_timeout'];
    if (json['orders'] != null) {
      orders = new List<OrdersD>();
      json['orders'].forEach((v) {
        orders.add(new OrdersD.fromJson(v));
      });
    }
    ownDelivery = json['own_delivery'];
    payNo = json['pay_no'];
    payTime = json['pay_time'];
    payTimeoutMs = json['pay_timeout_ms'];
    payType = json['pay_type'] != null
        ? new PayType.fromJson(json['pay_type'])
        : null;
    payment = json['payment'];
    postFee = json['post_fee'];
    if (json['promotions'] != null) {
      promotions = new List<Promotions>();
      json['promotions'].forEach((v) {
        promotions.add(new Promotions.fromJson(v));
      });
    }
    purchaseAmount = json['purchase_amount'];
    receivedPayment = json['received_payment'];
    sellerId = json['seller_id'];
    sellerNick = json['seller_nick'];
    shippingAddress = json['shipping_address'] != null
        ? new ShippingAddress.fromJson(json['shipping_address'])
        : null;
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    storeName = json['store_name'];
    taxFee = json['tax_fee'];
    totalFee = json['total_fee'];
    tradeId = json['trade_id'];
    tradeModel = json['trade_model'] != null
        ? new TradeModel.fromJson(json['trade_model'])
        : null;
    tradeOperate = json['trade_operate'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adjust_fee'] = this.adjustFee;
    data['consign_time'] = this.consignTime;
    data['contact'] = this.contact;
    data['created'] = this.created;
    data['distributor_id'] = this.distributorId;
    data['end_time'] = this.endTime;
    data['is_bought'] = this.isBought;
    data['mark_desc'] = this.markDesc;
    data['memo'] = this.memo;
    data['order_timeout'] = this.orderTimeout;
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    data['own_delivery'] = this.ownDelivery;
    data['pay_no'] = this.payNo;
    data['pay_time'] = this.payTime;
    data['pay_timeout_ms'] = this.payTimeoutMs;
    if (this.payType != null) {
      data['pay_type'] = this.payType.toJson();
    }
    data['payment'] = this.payment;
    data['post_fee'] = this.postFee;
    if (this.promotions != null) {
      data['promotions'] = this.promotions.map((v) => v.toJson()).toList();
    }
    data['purchase_amount'] = this.purchaseAmount;
    data['received_payment'] = this.receivedPayment;
    data['seller_id'] = this.sellerId;
    data['seller_nick'] = this.sellerNick;
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['store_name'] = this.storeName;
    data['tax_fee'] = this.taxFee;
    data['total_fee'] = this.totalFee;
    data['trade_id'] = this.tradeId;
    if (this.tradeModel != null) {
      data['trade_model'] = this.tradeModel.toJson();
    }
    data['trade_operate'] = this.tradeOperate;
    data['remark'] = this.remark;
    return data;
  }
}

class OrdersD {
  double commissionFee;
  int itemId;
  int num;
  String orderId;
  String orderOperate;
  double paymment;
  String picUrl;
  double price;
  String propertiesName;
  int refundId;
  RefundStatus refundStatus;
  int skuId;
  double taxFee;
  int taxRate;
  String title;
  int tradeId;

  OrdersD(
      {this.commissionFee,
      this.itemId,
      this.num,
      this.orderId,
      this.orderOperate,
      this.paymment,
      this.picUrl,
      this.price,
      this.propertiesName,
      this.refundId,
      this.refundStatus,
      this.skuId,
      this.taxFee,
      this.taxRate,
      this.title,
      this.tradeId});

  OrdersD.fromJson(Map<String, dynamic> json) {
    commissionFee = json['commission_fee'];
    itemId = json['item_id'];
    num = json['num'];
    orderId = json['order_id'];
    orderOperate = json['order_operate'];
    paymment = json['paymment'];
    picUrl = json['pic_url'];
    price = json['price'];
    propertiesName = json['properties_name'];
    refundId = json['refund_id'];
    refundStatus = json['refund_status'] != null
        ? new RefundStatus.fromJson(json['refund_status'])
        : null;
    skuId = json['sku_id'];
    taxFee = json['tax_fee'];
    taxRate = json['tax_rate'];
    title = json['title'];
    tradeId = json['trade_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commission_fee'] = this.commissionFee;
    data['item_id'] = this.itemId;
    data['num'] = this.num;
    data['order_id'] = this.orderId;
    data['order_operate'] = this.orderOperate;
    data['paymment'] = this.paymment;
    data['pic_url'] = this.picUrl;
    data['price'] = this.price;
    data['properties_name'] = this.propertiesName;
    data['refund_id'] = this.refundId;
    if (this.refundStatus != null) {
      data['refund_status'] = this.refundStatus.toJson();
    }
    data['sku_id'] = this.skuId;
    data['tax_fee'] = this.taxFee;
    data['tax_rate'] = this.taxRate;
    data['title'] = this.title;
    data['trade_id'] = this.tradeId;
    return data;
  }
}

class Promotions {
  String description;
  double paidPromotionFee;
  int promotionId;
  Null promotionItems;
  bool success;

  Promotions(
      {this.description,
      this.paidPromotionFee,
      this.promotionId,
      this.promotionItems,
      this.success});

  Promotions.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    paidPromotionFee = json['paid_promotion_fee'];
    promotionId = json['promotion_id'];
    promotionItems = json['promotion_items'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['paid_promotion_fee'] = this.paidPromotionFee;
    data['promotion_id'] = this.promotionId;
    data['promotion_items'] = this.promotionItems;
    data['success'] = this.success;
    return data;
  }
}

class ShippingAddress {
  String address;
  String detailAddress;
  String identityId;
  String mobile;
  Null phone;
  String receiverName;
  int regionId;
  Null zip;

  ShippingAddress(
      {this.address,
      this.detailAddress,
      this.identityId,
      this.mobile,
      this.phone,
      this.receiverName,
      this.regionId,
      this.zip});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    detailAddress = json['detail_address'];
    identityId = json['identity_id'];
    mobile = json['mobile'];
    phone = json['phone'];
    receiverName = json['receiver_name'];
    regionId = json['region_id'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['detail_address'] = this.detailAddress;
    data['identity_id'] = this.identityId;
    data['mobile'] = this.mobile;
    data['phone'] = this.phone;
    data['receiver_name'] = this.receiverName;
    data['region_id'] = this.regionId;
    data['zip'] = this.zip;
    return data;
  }
}

class PayType {
  String key;
  String value;

  PayType({this.key, this.value});

  PayType.fromJson(Map<String, dynamic> json) {
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

