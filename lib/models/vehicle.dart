class Vehicle {
  final String id;
  final String chassis;
  final String manifiesto;
  final String ordenservicio;
  final String idTravel;
  final String idServiceOrder;

  Vehicle({
    required this.id,
    required this.chassis,
    required this.manifiesto,
    required this.ordenservicio,
    required this.idTravel,
    required this.idServiceOrder,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      chassis: json['chassis'],
      manifiesto: json['manifiesto'],
      ordenservicio: json['ordenservicio'],
      idTravel: json['idTravel'],
      idServiceOrder: json['idServiceOrder'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chassis': chassis,
      'manifiesto': manifiesto,
      'ordenservicio': ordenservicio,
      'idTravel': idTravel,
      'idServiceOrder': idServiceOrder,
    };
  }
}
