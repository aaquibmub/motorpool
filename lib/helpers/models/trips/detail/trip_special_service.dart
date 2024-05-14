class TripSpecialService {
  final String name;
  final int qty;

  TripSpecialService(
    this.name,
    this.qty,
  );

  factory TripSpecialService.fromJson(dynamic json) => TripSpecialService(
        json['name'] as String,
        json['qty'] as int,
      );
}
