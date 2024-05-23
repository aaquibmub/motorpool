class VehicalHistory {
  final String id;
  final String vehicalId;
  final String plateNumber;
  final String make;
  final String model;
  final int modelYear;
  final bool allocated;
  final String odoMeter;
  final DateTime assignedOn;
  final String inspectionId;
  final bool inspectionCompleted;
  final bool assignedToUser;

  VehicalHistory(
      this.id,
      this.vehicalId,
      this.plateNumber,
      this.make,
      this.model,
      this.modelYear,
      this.allocated,
      this.odoMeter,
      this.assignedOn,
      this.inspectionId,
      this.inspectionCompleted,
      this.assignedToUser);

  factory VehicalHistory.fromJson(dynamic json) {
    return json != null
        ? VehicalHistory(
            json['id'] as String,
            json['vehicalId'] as String,
            json['plateNumber'] as String,
            json['make'] as String,
            json['model'] as String,
            json['modelYear'] as int,
            json['allocated'] as bool,
            json['odoMeter'] as String,
            json['assignedOn'] != null
                ? DateTime.parse(json['assignedOn'])
                : null,
            json['inspectionId'] as String,
            json['inspectionCompleted'] as bool,
            json['assignedToUser'] as bool,
          )
        : null;
  }
}
