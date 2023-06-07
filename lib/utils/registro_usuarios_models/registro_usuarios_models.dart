class RegistroUsarioItems {
  //final int id;
  int? id;
  String? codFotocheck;
  String? usuario;
  String? nombres;
  String? apellidos;
  String? firmaIMG;
  String? urlFirmaIMG;

  RegistroUsarioItems({
    //required this.id,
    this.id,
    this.codFotocheck,
    this.usuario,
    this.nombres,
    this.apellidos,
    this.firmaIMG,
    this.urlFirmaIMG,
  });
}

class RegistroTransporteItems {
  //final int id;
  int? id;
  String? transporte;
  String? ruc;
  String? codFotocheckTransporte;

  RegistroTransporteItems({
    //required this.id,
    this.id,
    this.transporte,
    this.ruc,
    this.codFotocheckTransporte,
  });
}
