import 'package:motorpool/helpers/models/vehicals/inspection/vehical_inspection_model.dart';

class ResponseModel<T> {
  final T result;
  final String msg;
  final bool hasError;

  int errorAction = null;
  String id = null;
  String label = null;

  ResponseModel(
    this.result,
    this.msg,
    this.hasError, {
    this.errorAction,
    this.id,
    this.label,
  });

  factory ResponseModel.fromJson(dynamic json) {
    if (T == VehicalInspectionModel) {
      VehicalInspectionModel result =
          VehicalInspectionModel.fromJson(json['result']);
      return ResponseModel<T>(
        result as T,
        json['msg'] as String,
        json['hasError'] as bool,
        errorAction: json['errorAction'] as int,
        id: json['id'] as String,
        label: json['label'] as String,
      );
    }

    return ResponseModel<T>(
      json['result'] as T,
      json['msg'] as String,
      json['hasError'] as bool,
      errorAction: json['errorAction'] as int,
      id: json['id'] as String,
      label: json['label'] as String,
    );
  }
}
