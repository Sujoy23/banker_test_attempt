class QueryConstants {
  static const String homeQuery = r''' 
  query getHome {
  home {
    name
    accountNumber
    balance
    currency
    address {
      streetName
      buildingNumber
      townName
      postCode
      country
    }
    recentTransactions {
      date
      description
      amount
      fromAccount
      toAccount
    }
    upcomingBills {
      date
      description
      amount
      fromAccount
      toAccount
    }
  }
}
  ''';
  static const String accountQuery = r'''
  query getAccounts {
  accounts {
    id
    accountNumber
    accountType
    balance
    accountHolder
  }
}
  ''';
  static const String loanQuery = 'loan';
  static const String contactQuery = r'''
  query getContacts {
  contacts
}
  ''';
  static const String transactionQuery = r'''
  query getTransactions {
  transactions {
    date
    description
    amount
    fromAccount
    toAccount
  }
}
  ''';
  static const String statementsQuery = r'''
  query getStatements {
  statements {
    date
    description
    amount
  }
}
  ''';
}