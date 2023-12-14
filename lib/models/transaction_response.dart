class TransactionResponse {
  List<Transactions>? transactions;

  TransactionResponse({this.transactions});

  TransactionResponse.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? date;
  String? description;
  double? amount;
  String? fromAccount;
  String? toAccount;

  Transactions(
      {this.date,
        this.description,
        this.amount,
        this.fromAccount,
        this.toAccount});

  Transactions.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    description = json['description'];
    amount = json['amount'];
    fromAccount = json['fromAccount'];
    toAccount = json['toAccount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['fromAccount'] = this.fromAccount;
    data['toAccount'] = this.toAccount;
    return data;
  }
}