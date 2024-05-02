class HomeModel {
  final Data data;

  HomeModel({
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final int totalEscrow;
  final int userId;
  final int completedEscrow;
  final int pendingEscrow;
  final int disputeEscrow;
  final List<UserWallet> userWallet;
  final List<Transaction> transactions;

  Data({
    required this.totalEscrow,
    required this.userId,
    required this.completedEscrow,
    required this.pendingEscrow,
    required this.disputeEscrow,
    required this.userWallet,
    required this.transactions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalEscrow: json["total_escrow"],
    userId: json["user_id"],
    completedEscrow: json["compledted_escrow"],
    pendingEscrow: json["pending_escrow"],
    disputeEscrow: json["dispute_escrow"],
    userWallet: List<UserWallet>.from(json["userWallet"].map((x) => UserWallet.fromJson(x))),
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
  );
}

class Transaction {
  final int id;
  final String trxId;
  final String gatewayCurrency;
  final String transactionType;
  final int senderRequestAmount;
  final String senderCurrencyCode;
  final String totalPayable;
  final String gatewayCurrencyCode;
  final double exchangeRate;
  final double fee;
  final dynamic rejectionReason;
  final dynamic exchangeCurrency;
  final int status;
  final String stringStatus;
  final DateTime createdAt;

  Transaction({
    required this.id,
    required this.trxId,
    required this.gatewayCurrency,
    required this.transactionType,
    required this.senderRequestAmount,
    required this.senderCurrencyCode,
    required this.totalPayable,
    required this.gatewayCurrencyCode,
    required this.exchangeRate,
    required this.fee,
    required this.rejectionReason,
    required this.exchangeCurrency,
    required this.status,
    required this.stringStatus,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"],
    trxId: json["trx_id"],
    gatewayCurrency: json["gateway_currency"] ?? "",
    transactionType: json["transaction_type"],
    senderRequestAmount: json["sender_request_amount"],
    senderCurrencyCode: json["sender_currency_code"],
    totalPayable: json["total_payable"],
    gatewayCurrencyCode: json["gateway_currency_code"] ?? "",
    exchangeRate: json["exchange_rate"].toDouble(),
    fee: json["fee"].toDouble(),
    rejectionReason: json["rejection_reason"],
    exchangeCurrency: json["exchange_currency"],
    status: json["status"],
    stringStatus: json["string_status"],
    createdAt: DateTime.parse(json["created_at"]),
  );
}

class UserWallet {
  final String name;
  final double balance;
  final String currencyCode;
  final String currencySymbol;
  final String currencyType;
  final double rate;
  final String flag;
  final String imagePath;

  UserWallet({
    required this.name,
    required this.balance,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyType,
    required this.rate,
    required this.flag,
    required this.imagePath,
  });

  factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
    name: json["name"],
    balance: json["balance"].toDouble(),
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
    currencyType: json["currency_type"],
    rate: json["rate"].toDouble(),
    flag: json["flag"],
    imagePath: json["image_path"],
  );
}