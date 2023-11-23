class TripPassengerListModel {
  final String id;
  final String name;

  TripPassengerListModel(
    this.id,
    this.name,
  );

  factory TripPassengerListModel.fromJson(dynamic json) =>
      TripPassengerListModel(
        json['id'] as String,
        json['name'] as String,
      );
}
