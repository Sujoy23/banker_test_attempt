class HomeResponse {
  Home? home;

  HomeResponse({this.home});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    home = json['home'] != null ? new Home.fromJson(json['home']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.home != null) {
      data['home'] = this.home!.toJson();
    }
    return data;
  }
}

class Home {
  String? name;
  String? accountNumber;
  double? balance;
  String? currency;
  Address? address;
  List<RecentTransactions>? recentTransactions;
  List<UpcomingBills>? upcomingBills;

  Home(
      {this.name,
        this.accountNumber,
        this.balance,
        this.currency,
        this.address,
        this.recentTransactions,
        this.upcomingBills});

  Home.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    accountNumber = json['accountNumber'];
    balance = json['balance'];
    currency = json['currency'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['recentTransactions'] != null) {
      recentTransactions = <RecentTransactions>[];
      json['recentTransactions'].forEach((v) {
        recentTransactions!.add(new RecentTransactions.fromJson(v));
      });
    }
    if (json['upcomingBills'] != null) {
      upcomingBills = <UpcomingBills>[];
      json['upcomingBills'].forEach((v) {
        upcomingBills!.add(new UpcomingBills.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['accountNumber'] = this.accountNumber;
    data['balance'] = this.balance;
    data['currency'] = this.currency;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.recentTransactions != null) {
      data['recentTransactions'] =
          this.recentTransactions!.map((v) => v.toJson()).toList();
    }
    if (this.upcomingBills != null) {
      data['upcomingBills'] =
          this.upcomingBills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  String? streetName;
  String? buildingNumber;
  String? townName;
  String? postCode;
  String? country;

  Address(
      {this.streetName,
        this.buildingNumber,
        this.townName,
        this.postCode,
        this.country});

  Address.fromJson(Map<String, dynamic> json) {
    streetName = json['streetName'];
    buildingNumber = json['buildingNumber'];
    townName = json['townName'];
    postCode = json['postCode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['streetName'] = this.streetName;
    data['buildingNumber'] = this.buildingNumber;
    data['townName'] = this.townName;
    data['postCode'] = this.postCode;
    data['country'] = this.country;
    return data;
  }
}

class RecentTransactions {
  String? date;
  String? description;
  int? amount;
  String? fromAccount;
  String? toAccount;

  RecentTransactions(
      {this.date,
        this.description,
        this.amount,
        this.fromAccount,
        this.toAccount});

  RecentTransactions.fromJson(Map<String, dynamic> json) {
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

class UpcomingBills {
  String? date;
  String? description;
  double? amount;
  String? fromAccount;
  String? toAccount;

  UpcomingBills(
      {this.date,
        this.description,
        this.amount,
        this.fromAccount,
        this.toAccount});

  UpcomingBills.fromJson(Map<String, dynamic> json) {
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