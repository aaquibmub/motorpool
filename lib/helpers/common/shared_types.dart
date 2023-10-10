enum DeviceType {
  Phone,
  Tablet,
  Monitor,
}

class SaleItemType {
  static const Deal = 10;
  static const Item = 20;
}

class TripStatus {
  static const Created = 10;
  static const AssignedToDriver = 20;
  static const TripStarted = 30;
  static const VehicalDispatched = 40;
  static const ArrivedAtPickupLocation = 50;
  static const WaitingForPassenger = 52;
  static const PassengerOnboarded = 55;
  static const ArrivedAtStop = 60;
  static const ArrivedAtDropoff = 70;
  static const Completed = 400;
}

class DestinationType {
  static const Pickup = 10;
  static const Stop = 20;
  static const Dropoff = 30;
}
