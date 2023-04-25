class CorporateRequest {
  final int userId, itemId;
  final String name, email, phone, message;

  CorporateRequest({
    required this.userId,
    required this.itemId,
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
  });
}
