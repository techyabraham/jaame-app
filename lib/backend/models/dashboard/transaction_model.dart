import 'home_model.dart';

class TransactionModel {
  final Data data;

  TransactionModel({
    required this.data,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final Transactions transactions;

  Data({
    required this.transactions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    transactions: Transactions.fromJson(json["transactions"]),
  );
}

class Transactions {
  final List<Transaction> data;
  final int lastPage;

  Transactions({
    required this.data,
    required this.lastPage,
  });

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
    data: List<Transaction>.from(json["data"].map((x) => Transaction.fromJson(x))),
    lastPage: json["last_page"],
  );
}