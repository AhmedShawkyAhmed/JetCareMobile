
class RegisterRequest {
  final String name;
  final String phone;
  final String email;
  final String password;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
}
