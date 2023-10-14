import 'package:motorpool/helpers/models/vehicals/inspection/vehical_inspection_model.dart';

class ResponseModel<T> {
  final T result;
  final String msg;
  final bool hasError;

  ResponseModel(
    this.result,
    this.msg,
    this.hasError,
  );

  factory ResponseModel.fromJson(dynamic json) {
    if (T == VehicalInspectionModel) {
      VehicalInspectionModel result =
          VehicalInspectionModel.fromJson(json['result']);
      return ResponseModel<T>(
        result as T,
        json['msg'] as String,
        json['hasError'] as bool,
      );
    }

    return ResponseModel<T>(
      json['result'] as T,
      json['msg'] as String,
      json['hasError'] as bool,
    );
  }
}
