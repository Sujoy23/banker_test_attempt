class StatementResponse {
  List<UserStatements>? statements;

  StatementResponse({this.statements});

  StatementResponse.fromJson(Map<String, dynamic> json) {
    if (json['statements'] != null) {
      statements = <UserStatements>[];
      json['statements'].forEach((v) {
        statements!.add(new UserStatements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.statements != null) {
      data['statements'] = this.statements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserStatements {
  String? date;
  String? description;
  double? amount;

  UserStatements({this.date, this.description, this.amount});

  UserStatements.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    description = json['description'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['description'] = this.description;
    data['amount'] = this.amount;
    return data;
  }
}