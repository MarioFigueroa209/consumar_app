import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/survey/sqlLiteModels/monitoreo_producto_sql_lite_model.dart';
import '../../../models/survey/sqlLiteModels/mp_bodega_foto.dart';
import '../../../models/survey/sqlLiteModels/mp_observado_foto.dart';

class DbLiteMonitoreoProducto {
  Future<Database> openDBMonitoreoProducto() async {
    return openDatabase(join(await getDatabasesPath(), 'monitoreoProducto.db'),
        onCreate: (db, version) {
      db.execute("DROP TABLE IF EXISTS monitoreoProducto");
      return db.execute(
          "CREATE TABLE monitoreoProducto (id_monitoreo_producto INTEGER PRIMARY KEY, jornada INTEGER, fecha DATETIME, inspeccion_fito TEXT, bodega TEXT,  humedad REAL, temp_est_proa REAL null, temp_est_popa REAL null, temp_centro REAL null, temp_babor_proa REAL null, temp_babor_popa REAL null, cantidad_danos REAL null, descripcion TEXT, idServiceOrder INTEGER,idUsuarios INTEGER)");
    }, version: 1);
  }

  Future<Database> openDBMpBodegaFotos() async {
    return openDatabase(join(await getDatabasesPath(), 'mpBodegaFotos.db'),
        onCreate: (db, version) {
      db.execute("DROP TABLE IF EXISTS mpBodegaFotos");
      return db.execute(
          "CREATE TABLE mpBodegaFotos (id_mp_foto INTEGER PRIMARY KEY, mp_url_foto TEXT null ,id_monitoreo_producto INTEGER null)");
    }, version: 1);
  }

  Future<Database> openDBMpObservandoFotos() async {
    return openDatabase(join(await getDatabasesPath(), 'mpObservandoFotos.db'),
        onCreate: (db, version) {
      db.execute("DROP TABLE IF EXISTS mpObservandoFotos");
      return db.execute(
          "CREATE TABLE mpObservandoFotos (id_mp_observado INTEGER PRIMARY KEY, mp_url_foto TEXT null, id_monitoreo_producto INTEGER null)");
    }, version: 1);
  }

  Future<int> insertMonitoreoProducto(
      MonitoreoProductoSqlLiteModel monitoreoProducto,
      List<MpBodegaFoto> mpBodegaFotos,
      List<MpObservadoFoto> mpObservadoFotos) async {
    Database dBMonitoreoProducto = await openDBMonitoreoProducto();
    Database dBBodegaFotos = await openDBMpBodegaFotos();
    Database dBObservandoFotos = await openDBMpObservandoFotos();
    Batch batchBodegaFotos = dBBodegaFotos.batch();
    Batch batchbservandoFotos = dBObservandoFotos.batch();
    final result = await dBMonitoreoProducto.insert(
        "monitoreoProducto", monitoreoProducto.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    for (int count = 0; count < mpBodegaFotos.length; count++) {
      batchBodegaFotos.insert("mpBodegaFotos", {
        "mp_url_foto": mpBodegaFotos[count].mpUrlFoto,
        "id_monitoreo_producto": result
      });
    }
    for (int count = 0; count < mpObservadoFotos.length; count++) {
      batchbservandoFotos.insert("mpObservandoFotos", {
        "mp_url_foto": mpObservadoFotos[count].mpUrlFoto,
        "id_monitoreo_producto": result
      });
    }
    await batchBodegaFotos.commit();
    await batchbservandoFotos.commit();
    //print("ultimo id registrado $result");
    //print("cantidad de lista de mpBodegaFotos ${mpBodegaFotos.length}");
    //print("cantidad de lista de mpObservandoFotos ${mpObservadoFotos.length}");

    return result;
  }

  Future<List<MonitoreoProductoSqlLiteModel>>
      listMonitoreoProductoTableSqlLite() async {
    Database database = await openDBMonitoreoProducto();
    List<Map> maps = await database.query("monitoreoProducto", columns: [
      "id_monitoreo_producto",
      "bodega",
      "humedad",
      "temp_est_proa",
      "temp_est_popa",
      "temp_centro",
      "temp_babor_proa",
      "temp_babor_popa"
    ]);
    return List.generate(
        maps.length,
        (i) => MonitoreoProductoSqlLiteModel(
              idMonitoreoProducto: maps[i]['id_monitoreo_producto'],
              bodega: maps[i]['bodega'],
              humedad: maps[i]['humedad'],
              tempEstProa: maps[i]['temp_est_proa'],
              tempEstPopa: maps[i]['temp_est_popa'],
              tempCentro: maps[i]['temp_centro'],
              tempBaborProa: maps[i]['temp_babor_proa'],
              tempBaborPopa: maps[i]['temp_babor_popa'],
            ));
  }

  Future<List<MonitoreoProductoSqlLiteModel>>
      getMonitoreoProductoListSqlLite() async {
    Database database = await openDBMonitoreoProducto();
    List<Map> maps = await database.query("monitoreoProducto", columns: [
      "id_monitoreo_producto",
      "jornada",
      "fecha",
      "inspeccion_fito",
      "bodega",
      "humedad",
      "temp_est_proa",
      "temp_est_popa",
      "temp_centro",
      "temp_babor_proa",
      "temp_babor_popa",
      "cantidad_danos",
      "descripcion",
      "idServiceOrder",
      "idUsuarios"
    ]);
    return List.generate(
        maps.length,
        (i) => MonitoreoProductoSqlLiteModel(
              idMonitoreoProducto: maps[i]['id_monitoreo_producto'],
              jornada: maps[i]['jornada'],
              fecha: DateTime.tryParse(maps[i]['fecha']),
              inspeccionFito: maps[i]['inspeccion_fito'],
              bodega: maps[i]['bodega'],
              humedad: maps[i]['humedad'],
              tempEstProa: maps[i]['temp_est_proa'],
              tempEstPopa: maps[i]['temp_est_popa'],
              tempCentro: maps[i]['temp_centro'],
              tempBaborProa: maps[i]['temp_babor_proa'],
              tempBaborPopa: maps[i]['temp_babor_popa'],
              cantidadDanos: maps[i]['cantidad_danos'],
              descripcion: maps[i]['descripcion'],
              idServiceOrder: maps[i]['idServiceOrder'],
              idUsuarios: maps[i]['idUsuarios'],
            ));
  }

  Future<List<MpBodegaFoto>> getListMpBodegaFotoSqlLite() async {
    Database database = await openDBMpBodegaFotos();
    List<Map> maps = await database.query("mpBodegaFotos",
        columns: ["mp_url_foto", "id_monitoreo_producto"]);
    return List.generate(
        maps.length,
        (i) => MpBodegaFoto(
            mpUrlFoto: maps[i]['mp_url_foto'],
            idMonitoreoProducto: maps[i]['id_monitoreo_producto']));
  }

  Future<List<MpObservadoFoto>> getListMPObservadoFotoSqlLite() async {
    Database database = await openDBMpObservandoFotos();
    List<Map> maps = await database.query("mpObservandoFotos",
        columns: ["mp_url_foto", "id_monitoreo_producto"]);
    return List.generate(
        maps.length,
        (i) => MpObservadoFoto(
              mpUrlFoto: maps[i]['mp_url_foto'],
              idMonitoreoProducto: maps[i]['id_monitoreo_producto'],
            ));
  }

  Future<int> clearTables() async {
    Database database = await openDBMonitoreoProducto();
    Database dBBodegaFotos = await openDBMpBodegaFotos();
    Database dbObservandoFoto = await openDBMpObservandoFotos();
    await dBBodegaFotos.delete("mpBodegaFotos");
    await dbObservandoFoto.delete("mpObservandoFotos");
    return database.delete("monitoreoProducto");
  }

  Future<int> deleteMonitoreoProductotByID(int idMonitoreo) async {
    Database database = await openDBMonitoreoProducto();

    return database.delete("monitoreoProducto",
        where: '"id_monitoreo_producto"=?', whereArgs: [idMonitoreo]);
  }

  Future<int> deleteBodegaFotostByIDMonitoreo(int idMonitoreo) async {
    Database database = await openDBMpBodegaFotos();

    return database.delete("mpBodegaFotos",
        where: '"id_monitoreo_producto"=?', whereArgs: [idMonitoreo]);
  }

  Future<int> deleteObservandoFotosByIDMonitoreo(int idMonitoreo) async {
    Database database = await openDBMpObservandoFotos();

    return database.delete("mpObservandoFotos",
        where: '"id_monitoreo_producto"=?', whereArgs: [idMonitoreo]);
  }
}
