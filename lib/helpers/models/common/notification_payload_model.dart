class NotificationPayloadModel {
  final String EventId;
  final String Data;

  NotificationPayloadModel(
    this.EventId,
    this.Data,
  );

  factory NotificationPayloadModel.fromJson(dynamic json) =>
      NotificationPayloadModel(
        json != null ? json['EventId'] as String : null,
        json != null ? json['Data'] as String : null,
      );
}
