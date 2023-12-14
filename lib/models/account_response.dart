class AccountResponse {
  List<AccountsDetails>? accounts;

  AccountResponse({this.accounts});

  AccountResponse.fromJson(Map<String, dynamic> json) {
    if (json['accounts'] != null) {
      accounts = <AccountsDetails>[];
      json['accounts'].forEach((v) {
        accounts!.add(new AccountsDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.accounts != null) {
      data['accounts'] = this.accounts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AccountsDetails {
  String? id;
  String? accountNumber;
  String? accountType;
  double? balance;
  String? accountHolder;

  AccountsDetails(
      {this.id,
        this.accountNumber,
        this.accountType,
        this.balance,
        this.accountHolder});

  AccountsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountNumber = json['accountNumber'];
    accountType = json['accountType'];
    balance = json['balance'];
    accountHolder = json['accountHolder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['accountNumber'] = this.accountNumber;
    data['accountType'] = this.accountType;
    data['balance'] = this.balance;
    data['accountHolder'] = this.accountHolder;
    return data;
  }
}