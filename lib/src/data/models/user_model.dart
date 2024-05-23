class UserModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? fcm;
  num? rate;
  String? role;
  int? active;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.fcm,
    this.rate,
    this.role,
    this.active,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? "",
        phone: json['phone'] ?? "",
        email: json['email'] ?? "",
        role: json['role'] ?? "",
        fcm: json['fcm'] ?? "",
        rate: json['rate'] ?? 0,
        active: json['active'] ?? 0,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['role'] = role;
    data['fcm'] = fcm;
    data['rate'] = rate;
    data['active'] = active;
    return data;
  }
}
