class ApiResponse {
  bool isError;
  String errorMessage;
  String data;

  ApiResponse(
    this.isError,
    this.errorMessage,
    this.data,
  );
  factory ApiResponse.fromMap(Map<String, dynamic> json) {
    return ApiResponse(json['error'], json['error_message'], json['response']);
  }
  Map<String, dynamic> toMap() {
    return {
      'error': isError,
      'error_message': errorMessage,
      'response': data,
    };
  }
}
