class UserModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  num? rate;
  String? role;
  int? active;
  int? archive;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.rate,
    this.role,
    this.active,
    this.archive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        rate: json['rate'] as num?,
        role: json['role'] as String?,
        active: json['active'] as int?,
        archive: json['archive'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'rate': rate,
        'role': role,
        'active': active,
        'archive': archive,
      };
}
