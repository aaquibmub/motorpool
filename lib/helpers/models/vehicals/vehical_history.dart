class VehicalHistory {
  final String id;
  final String vehicalId;
  final String plateNumber;
  final String make;
  final String model;
  final int modelYear;
  final DateTime assignedOn;

  VehicalHistory(
    this.id,
    this.vehicalId,
    this.plateNumber,
    this.make,
    this.model,
    this.modelYear,
    this.assignedOn,
  );

  factory VehicalHistory.fromJson(dynamic json) {
    return json != null
        ? VehicalHistory(
            json['id'] as String,
            json['vehicalId'] as String,
            json['plateNumber'] as String,
            json['make'] as String,
            json['model'] as String,
            json['modelYear'] as int,
            json['assignedOn'] != null
                ? DateTime.parse(json['assignedOn'])
                : null,
          )
        : null;
  }
}
