class Vehicle {
  final String id;
  final String chassis;
  final String idTravel;
  final String idServiceOrder;

  Vehicle({
    required this.id,
    required this.chassis,
    required this.idTravel,
    required this.idServiceOrder,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      chassis: json['chassis'],
      idTravel: json['idTravel'],
      idServiceOrder: json['idServiceOrder'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chassis': chassis,
      'idTravel': idTravel,
      'idServiceOrder': idServiceOrder,
    };
  }
}