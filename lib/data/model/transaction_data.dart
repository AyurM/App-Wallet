enum TransactionType { expense, income }

class TransactionData {
  final String title;
  final String imagePath;
  final double value;
  final DateTime dateTime;
  final TransactionType type;
  final String currency;

  const TransactionData(
      {required this.title,
      required this.imagePath,
      required this.value,
      required this.dateTime,
      required this.type,
      this.currency = '€'});
}
