class Login {
  Data data;

  Login({this.data});

  Login.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  bool isSuccess;
  Token token;
  User user;
  String msg;

  Data({this.isSuccess, this.token, this.user, this.msg});

  Data.fromJson(Map<String, dynamic> json) {
    isSuccess = json['is_success'];
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    msg = json['msg'] != null ? json['msg'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_success'] = this.isSuccess;
    if (this.token != null) {
      data['token'] = this.token.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.user != null) {
      data['msg'] = this.msg;
    }
    return data;
  }
}

class Token {
  String accessToken;
  int expiresIn;
  String refreshToken;
  String tokenType;

  Token({this.accessToken, this.expiresIn, this.refreshToken, this.tokenType});

  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['expires_in'] = this.expiresIn;
    data['refresh_token'] = this.refreshToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}

class User {
  bool auditStatus;
  int followUserId;
  String nick;
  int shopId;
  int status;
  int userId;
  String userName;
  int userType;

  User(
      {this.auditStatus,
      this.followUserId,
      this.nick,
      this.shopId,
      this.status,
      this.userId,
      this.userName,
      this.userType});

  User.fromJson(Map<String, dynamic> json) {
    auditStatus = json['audit_status'];
    followUserId = json['follow_user_id'];
    nick = json['nick'];
    shopId = json['shop_id'];
    status = json['status'];
    userId = json['user_id'];
    userName = json['user_name'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audit_status'] = this.auditStatus;
    data['follow_user_id'] = this.followUserId;
    data['nick'] = this.nick;
    data['shop_id'] = this.shopId;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_type'] = this.userType;
    return data;
  }
}
