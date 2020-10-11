class ApiResponse {
  bool status;
  dynamic data;

  ApiResponse.fromJson(Map<String, dynamic> json)
      : status = json['success'] == 0 ? true : false,
        data = json['data'];

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data,
      };
}
