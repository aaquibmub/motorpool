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
  static const OdoMeterAtStart = 35;
  static const VehicalDispatched = 40;
  static const ArrivedAtPickupLocation = 50;
  static const WaitingForPassenger = 52;
  static const PassengerOnboarded = 55;
  static const ArrivedAtStop = 60;
  static const WaitingForStopActivity = 62;
  static const TripResumedAfterStop = 65;
  static const ArrivedAtAddress = 66;
  static const WaitingForAddressActivity = 67;
  static const TripResumedAfterAddress = 68;
  static const ArrivedAtDropoff = 70;
  static const OdoMeterAtEnd = 80;
  static const Completed = 400;
}

class DestinationType {
  static const Pickup = 10;
  static const Stop = 20;
  static const Dropoff = 30;
  static const Address = 40;
}

class DamageLevel {
  static const S1 = 10;
  static const S2 = 20;

  static const D1 = 30;
  static const D2 = 40;

  static const M1 = 50;
  static const M2 = 60;
}
