class ValvulasIngreso {
  ValvulasIngreso({
    this.id,
    this.valvulasIngreso,
  });

  int? id;
  String? valvulasIngreso;
}

class ValvulasSalida {
  ValvulasSalida({
    this.id,
    this.valvulasSalida,
  });

  int? id;
  String? valvulasSalida;
}

class ListaLiquidaPrecintos {
  ListaLiquidaPrecintos({
    this.id,
    this.codigoPrecinto,
    this.tipoPrecinto,
  });

  int? id;
  String? codigoPrecinto;
  String? tipoPrecinto;
}
