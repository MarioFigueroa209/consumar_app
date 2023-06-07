import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/roro/printer_app/create_sql_lite_printer_app.dart';
import '../../../models/roro/printer_app/insert_printer_app_pendientes.dart';

class DbPrinterApp {
  //creacion de tabla printerApp_etiquetados
  Future<Database> openDBPrinterAppEtiquetados() async {
    return openDatabase(
        join(await getDatabasesPath(), 'printerApp_etiquetados.db'),
        onCreate: (db, version) {
      db.execute("DROP TABLE IF EXISTS printerApp_etiquetados");
      return db.execute(
          "CREATE TABLE printerApp_etiquetados (idPrEtiquetados INTEGER PRIMARY KEY, idOrdenServicio INTEGER, idVehicle INTEGER, idUsuario INTEGER, chasis TEXT, marca TEXT,modelo TEXT, detalle TEXT, estado TEXT, jornada INTEGER)");
    }, version: 1);
  }

  //creacion de tabla printerApp_pendientes
  Future<Database> openDBPrinterAppPendientes() async {
    return openDatabase(
        join(await getDatabasesPath(), 'printerApp_pendientes.db'),
        onCreate: (db, version) {
      db.execute("DROP TABLE IF EXISTS printerApp_pendientes");
      return db.execute(
          "CREATE TABLE printerApp_pendientes (idPrPendientes INTEGER PRIMARY KEY, idOrdenServicio INTEGER, idVehicle INTEGER, chasis TEXT, marca TEXT,modelo TEXT, estado TEXT, detalle TEXT, operacion TEXT)");
    }, version: 1);
  }

  //creacion de registro de etiquetado de vehiculos
  Future<CreateSqlLitePrinterApp> createPrinterAppEtiquetado(
      CreateSqlLitePrinterApp createSqlLitePrinterApp) async {
    Database database = await openDBPrinterAppEtiquetados();
    await database.insert(
        "printerApp_etiquetados", createSqlLitePrinterApp.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return createSqlLitePrinterApp;
  }

  //insertar listado de vehiculos sin etiquetar de la web hacia la bd en local
  Future<List> insertPrinterPendientesData(
      List<InsertPrinterAppPendientes> vwPrinterAppPendientes) async {
    Database database = await openDBPrinterAppPendientes();
    database.delete("printerApp_pendientes");
    Batch batch = database.batch();
    for (int count = 0; count < vwPrinterAppPendientes.length; count++) {
      batch.insert("printerApp_pendientes", {
        "idOrdenServicio": vwPrinterAppPendientes[count].idServiceOrder,
        "idVehicle": vwPrinterAppPendientes[count].idVehiculo,
        "chasis": vwPrinterAppPendientes[count].chasis,
        "marca": vwPrinterAppPendientes[count].marca,
        "modelo": vwPrinterAppPendientes[count].modelo,
        "estado": vwPrinterAppPendientes[count].estado,
        "detalle": vwPrinterAppPendientes[count].detalle,
        "operacion": vwPrinterAppPendientes[count].operacion
      });
    }
    final results = await batch.commit();
    return results;
  }

  //obtener lista de vehiculos etiquetados
  Future<List<CreateSqlLitePrinterApp>>
      getSqlLitePrinterAppEtiquetados() async {
    Database database = await openDBPrinterAppEtiquetados();
    List<Map> maps = await database.query("printerApp_etiquetados", columns: [
      "idPrEtiquetados",
      "chasis",
      "marca",
      "modelo",
      "detalle",
      "estado",
      "idOrdenServicio",
      "idVehicle",
      "idUsuario",
      "jornada",
    ]);
    return List.generate(
        maps.length,
        (i) => CreateSqlLitePrinterApp(
              idPrEtiquetados: maps[i]['idPrEtiquetados'],
              chasis: maps[i]['chasis'],
              marca: maps[i]['marca'],
              modelo: maps[i]['modelo'],
              detalle: maps[i]['detalle'],
              estado: maps[i]['estado'],
              jornada: maps[i]['jornada'],
              idUsuarios: maps[i]['idUsuario'],
              idVehicle: maps[i]['idVehicle'],
              idServiceOrder: maps[i]['idOrdenServicio'],
            ));
  }

  //obtener lista de vehiculos pendientes a etiquetar
  Future<List<InsertPrinterAppPendientes>> listPrinterPendientesData() async {
    Database database = await openDBPrinterAppPendientes();
    final List<Map<String, dynamic>> printeAppSqlLiteConsulta =
        await database.query(
      "printerApp_pendientes",
      columns: [
        "idPrPendientes",
        "idVehicle",
        "chasis",
        "marca",
        "modelo",
        "estado",
        "detalle"
      ],
      where: 'estado="pendiente"',
    );
    return List.generate(
        printeAppSqlLiteConsulta.length,
        (i) => InsertPrinterAppPendientes(
            idPrinterAppPendientes: printeAppSqlLiteConsulta[i]
                ['idPrPendientes'],
            idServiceOrder: printeAppSqlLiteConsulta[i]['idOrdenServicio'],
            idVehiculo: printeAppSqlLiteConsulta[i]['idVehicle'],
            chasis: printeAppSqlLiteConsulta[i]['chasis'],
            marca: printeAppSqlLiteConsulta[i]['marca'],
            modelo: printeAppSqlLiteConsulta[i]['modelo'],
            estado: printeAppSqlLiteConsulta[i]['estado'],
            detalle: printeAppSqlLiteConsulta[i]['detalle']));
  }

  Future<int> update(
      InsertPrinterAppPendientes insertPrinterAppPendientes) async {
    Database database = await openDBPrinterAppPendientes();

    return database.update(
        "printerApp_pendientes", insertPrinterAppPendientes.toJson(),
        where: 'idPrPendientes = ?',
        whereArgs: [insertPrinterAppPendientes.idPrinterAppPendientes]);
  }

  Future<int> clearTablePrinterAppEtiquetados() async {
    Database database = await openDBPrinterAppEtiquetados();

    return database.delete("printerApp_etiquetados");
  }

  Future<InsertPrinterAppPendientes> getPrinterAppPendientesById(
      int idPendientes) async {
    Database database = await openDBPrinterAppPendientes();
    final maps = await database.query("printerApp_pendientes",
        columns: [
          "idPrPendientes",
          "idOrdenServicio",
          "idVehicle",
          "chasis",
          "marca",
          "modelo",
          "estado",
          "detalle",
          "operacion"
        ],
        where: '"idPrPendientes"=?',
        whereArgs: [idPendientes]);
    if (maps.isNotEmpty) {
      return InsertPrinterAppPendientes.fromJson(maps.first);
    } else {
      throw Exception("no se pudo obtener registros");
    }
  }
}
