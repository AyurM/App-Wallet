class CreditCardInput {
  final String cardNumber;
  final String ownerName;
  final DateTime expirationDate;
  final String code;

  const CreditCardInput({
    required this.cardNumber,
    required this.ownerName,
    required this.expirationDate,
    required this.code,
  });
}
