class Vehical {
  final String id;
  final String make;
  final String model;
  final int modelYear;

  Vehical(
    this.id,
    this.make,
    this.model,
    this.modelYear,
  );

  factory Vehical.fromJson(dynamic json) {
    return json != null
        ? Vehical(
            json['id'] as String,
            json['make'] as String,
            json['model'] as String,
            json['modelYear'] as int,
          )
        : null;
  }
}
