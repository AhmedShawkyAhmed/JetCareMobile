class NetworkBaseModel<T> {
  int status;
  String message;
  T? data;

  NetworkBaseModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory NetworkBaseModel.fromJson(Map<String, dynamic> json) =>
      NetworkBaseModel(
        status: json['status'] as int,
        message: json['message'] as String,
        data: json['data'] as T?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data,
      };
}
