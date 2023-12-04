class VehicalInspectionHistory {
  final String id;
  final String inspectionId;
  final String vehicalId;
  final String plateNumber;
  final DateTime inspectedOn;

  VehicalInspectionHistory(
    this.id,
    this.inspectionId,
    this.vehicalId,
    this.plateNumber,
    this.inspectedOn,
  );

  factory VehicalInspectionHistory.fromJson(dynamic json) {
    return json != null
        ? VehicalInspectionHistory(
            json['id'] as String,
            json['inspectionId'] as String,
            json['vehicalId'] as String,
            json['plateNumber'] as String,
            json['inspectedOn'] != null
                ? DateTime.parse(json['inspectedOn'])
                : null,
          )
        : null;
  }
}
