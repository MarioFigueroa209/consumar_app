import 'package:consumar_app/models/vehicle.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbPrinterApp {
  //creacion de tabla printerApp_etiquetados
  Future<Database> openDBPrinterAppEtiquetados() async {
    return openDatabase(
        join(await getDatabasesPath(), 'printerApp_etiquetados.db'),
        onCreate: (db, version) {
      db.execute("DROP TABLE IF EXISTS printerApp_etiquetados");
      return db.execute(
          "CREATE TABLE printerApp_etiquetados (id TEXT, chassis TEXT, manifiesto TEXT, ordenservicio TEXT, idServiceOrder TEXT, idTravel TEXT)");
    }, version: 1);
  }

  //creacion de registro de etiquetado de vehiculos
  Future<Vehicle> createPrinterAppEtiquetado(
      Vehicle createSqlLitePrinterApp) async {
    Database database = await openDBPrinterAppEtiquetados();
    await database.insert(
        "printerApp_etiquetados", createSqlLitePrinterApp.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return createSqlLitePrinterApp;
  }

  //obtener lista de vehiculos etiquetados
  Future<List<Vehicle>> getSqlLitePrinterAppEtiquetados() async {
    Database database = await openDBPrinterAppEtiquetados();
    List<Map> maps = await database.query("printerApp_etiquetados", columns: [
      "id",
      "chassis",
      "manifiesto",
      "ordenservicio",
      "idTravel",
      "idServiceOrder"
    ]);
    return List.generate(
        maps.length,
        (i) => Vehicle(
              id: maps[i]['id'],
              chassis: maps[i]['chassis'],
              manifiesto: maps[i]['manifiesto'],
              ordenservicio: maps[i]['ordenservicio'],
              idTravel: maps[i]['idTravel'],
              idServiceOrder: maps[i]['idServiceOrder'],
            ));
  }

  Future<int> clearTablePrinterAppEtiquetados() async {
    Database database = await openDBPrinterAppEtiquetados();

    return database.delete("printerApp_etiquetados");
  }
}
