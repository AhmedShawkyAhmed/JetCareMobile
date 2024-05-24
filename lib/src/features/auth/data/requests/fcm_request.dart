class FCMRequest {
  final int id;
  final String fcm;

  FCMRequest({
    required this.id,
    required this.fcm,
  });

  factory FCMRequest.fromJson(Map<String, dynamic> json) => FCMRequest(
    id: json['id'] as int,
    fcm: json['fcm'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'fcm': fcm,
  };
}
