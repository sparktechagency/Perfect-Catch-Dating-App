class WalletModel {
  final UserWallet? userWallet;
  final int? totalWithdraw;

  WalletModel({
    this.userWallet,
    this.totalWithdraw,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
    userWallet: json["userWallet"] == null ? null : UserWallet.fromJson(json["userWallet"]),
    totalWithdraw: json["totalWithdraw"],
  );

  Map<String, dynamic> toJson() => {
    "userWallet": userWallet?.toJson(),
    "totalWithdraw": totalWithdraw,
  };
}

class UserWallet {
  final Limits? limits;
  final Security? security;
  final Metadata? metadata;
  final String? userId;
  final int? balance;
  final String? currency;
  final List<Transaction>? transactions;
  final DateTime? createdAt;
  final String? id;

  UserWallet({
    this.limits,
    this.security,
    this.metadata,
    this.userId,
    this.balance,
    this.currency,
    this.transactions,
    this.createdAt,
    this.id,
  });

  factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
    limits: json["limits"] == null ? null : Limits.fromJson(json["limits"]),
    security: json["security"] == null ? null : Security.fromJson(json["security"]),
    metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
    userId: json["userId"],
    balance: json["balance"],
    currency: json["currency"],
    transactions: json["transactions"] == null ? [] : List<Transaction>.from(json["transactions"]!.map((x) => Transaction.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "limits": limits?.toJson(),
    "security": security?.toJson(),
    "metadata": metadata?.toJson(),
    "userId": userId,
    "balance": balance,
    "currency": currency,
    "transactions": transactions == null ? [] : List<dynamic>.from(transactions!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "id": id,
  };
}

class Limits {
  final int? dailyLimit;
  final int? monthlyLimit;

  Limits({
    this.dailyLimit,
    this.monthlyLimit,
  });

  factory Limits.fromJson(Map<String, dynamic> json) => Limits(
    dailyLimit: json["dailyLimit"],
    monthlyLimit: json["monthlyLimit"],
  );

  Map<String, dynamic> toJson() => {
    "dailyLimit": dailyLimit,
    "monthlyLimit": monthlyLimit,
  };
}

class Metadata {
  final String? walletName;
  final String? notes;

  Metadata({
    this.walletName,
    this.notes,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    walletName: json["walletName"],
    notes: json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "walletName": walletName,
    "notes": notes,
  };
}

class Security {
  final String? pin;
  final bool? twoFactorEnabled;

  Security({
    this.pin,
    this.twoFactorEnabled,
  });

  factory Security.fromJson(Map<String, dynamic> json) => Security(
    pin: json["pin"],
    twoFactorEnabled: json["twoFactorEnabled"],
  );

  Map<String, dynamic> toJson() => {
    "pin": pin,
    "twoFactorEnabled": twoFactorEnabled,
  };
}

class Transaction {
  final String? transactionId;
  final String? type;
  final int? amount;
  final String? currency;
  final DateTime? timestamp;
  final String? description;
  final String? infoType;
  final String? status;

  Transaction({
    this.transactionId,
    this.type,
    this.amount,
    this.currency,
    this.timestamp,
    this.description,
    this.infoType,
    this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    transactionId: json["transactionId"],
    type: json["type"],
    amount: json["amount"],
    currency: json["currency"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    description: json["description"],
    infoType: json["infoType"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "transactionId": transactionId,
    "type": type,
    "amount": amount,
    "currency": currency,
    "timestamp": timestamp?.toIso8601String(),
    "description": description,
    "infoType": infoType,
    "status": status,
  };
}
