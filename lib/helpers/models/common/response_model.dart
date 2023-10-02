class ResponseModel<T> {
  final T result;
  final String msg;
  final bool hasError;

  ResponseModel(
    this.result,
    this.msg,
    this.hasError,
  );

  factory ResponseModel.fromJson(dynamic json) => ResponseModel<T>(
        json['result'] as T,
        json['msg'] as String,
        json['hasError'] as bool,
      );
}
