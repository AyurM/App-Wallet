enum TransactionType {
  income,
  expense;

  String get title => name[0].toUpperCase() + name.substring(1);
}
