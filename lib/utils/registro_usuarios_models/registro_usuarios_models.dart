class RegistroUsarioItems {
  int? id;
  String? codFotocheck;
  String? usuario;
  String? puesto;
  String? nombres;
  String? apellidos;
  String? firmaIMG;
  String? urlFirmaIMG;

  RegistroUsarioItems({
    this.id,
    this.codFotocheck,
    this.usuario,
    this.puesto,
    this.nombres,
    this.apellidos,
    this.firmaIMG,
    this.urlFirmaIMG,
  });
}

class RegistroTransporteItems {
  int? id;
  String? transporte;
  String? ruc;
  String? codFotocheckTransporte;

  RegistroTransporteItems({
    this.id,
    this.transporte,
    this.ruc,
    this.codFotocheckTransporte,
  });
}
