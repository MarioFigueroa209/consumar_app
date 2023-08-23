import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/carga_liquida/SqlLiquidaModels/sqlite_ulaje.dart';
import '../../models/carga_liquida/SqlLiquidaModels/sqlite_ulaje_observados_fotos.dart';
import '../../models/carga_liquida/SqlLiquidaModels/sqlite_ulaje_tanque_fotos.dart';
import '../../models/carga_liquida/ulaje/vw_tanque_pesos_liquida_by_idServOrder.dart';

class DbUlaje {
  Future<Database> openDBliquidaUlaje() async {
    return openDatabase(join(await getDatabasesPath(), 'liquidaUlaje.db'),
        onCreate: (db, version) {
      db.execute("DROP TABLE IF EXISTS liquidaUlaje");
      return db.execute(
          "CREATE TABLE liquidaUlaje (idUlaje INTEGER PRIMARY KEY, jornada INTEGER, fecha DATETIME, tanque TEXT, peso REAL,  temperatura REAL, descripcionDano TEXT null, cantidadDano REAL null, descripcionComentarios REAL null, idServiceOrder INTEGER, idUsuario INTEGER)");
    }, version: 1);
  }

  Future<Database> openDBUlajeObservadosFotos() async {
    return openDatabase(
        join(await getDatabasesPath(), 'liquidaUlajeObservadosFotos.db'),
        onCreate: (db, version) {
      db.execute("DROP TABLE IF EXISTS liquidaUlajeObservadosFotos");
      return db.execute(
          "CREATE TABLE liquidaUlajeObservadosFotos (id_observado_foto INTEGER PRIMARY KEY, ulajeUrlFoto TEXT null ,idUlaje INTEGER null)");
    }, version: 1);
  }

  Future<Database> openDBUlajeTanquesFotos() async {
    return openDatabase(
        join(await getDatabasesPath(), 'liquidaUlajeTanquesFotos.db'),
        onCreate: (db, version) {
      db.execute("DROP TABLE IF EXISTS liquidaUlajeTanquesFotos");
      return db.execute(
          "CREATE TABLE liquidaUlajeTanquesFotos (id_tanque_foto INTEGER PRIMARY KEY, tanqueUrlFoto TEXT null, idUlaje INTEGER null)");
    }, version: 1);
  }

  Future<int> insertUlajeSqlLite(
      SqliteUlaje sqliteUlaje,
      List<SqliteUlajeObservadosFotos> sqliteUlajeObservadosFotos,
      List<SqliteUlajeTanqueFotos> sqliteUlajeTanqueFotos) async {
    Database dBliquidaUlaje = await openDBliquidaUlaje();
    Database dBUlajeObservadosFotos = await openDBUlajeObservadosFotos();
    Database dBUlajeTanquesFotos = await openDBUlajeTanquesFotos();
    Batch batchObservadosFotos = dBUlajeObservadosFotos.batch();
    Batch batchTanquesFotos = dBUlajeTanquesFotos.batch();
    final result = await dBliquidaUlaje.insert(
        "liquidaUlaje", sqliteUlaje.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    for (int count = 0; count < sqliteUlajeObservadosFotos.length; count++) {
      batchObservadosFotos.insert("liquidaUlajeObservadosFotos", {
        "ulajeUrlFoto": sqliteUlajeObservadosFotos[count].ulajeUrlFoto,
        "idUlaje": result
      });
    }
    for (int count = 0; count < sqliteUlajeTanqueFotos.length; count++) {
      batchTanquesFotos.insert("liquidaUlajeTanquesFotos", {
        "tanqueUrlFoto": sqliteUlajeTanqueFotos[count].tanqueUrlFoto,
        "idUlaje": result
      });
    }
    await batchObservadosFotos.commit();
    await batchTanquesFotos.commit();
    //print("ultimo id registrado $result");
    //print("cantidad de lista de mpBodegaFotos ${mpBodegaFotos.length}");
    //print("cantidad de lista de mpObservandoFotos ${mpObservadoFotos.length}");

    return result;
  }

  Future<List<SqliteUlaje>> getUlajeListSqlLite() async {
    Database database = await openDBliquidaUlaje();
    List<Map> maps = await database.query("liquidaUlaje", columns: [
      "idUlaje",
      "jornada",
      "fecha",
      "tanque",
      "peso",
      "temperatura",
      "cantidadDano",
      "descripcionDano",
      "descripcionComentarios",
      "idServiceOrder",
      "idUsuario"
    ]);
    return List.generate(
        maps.length,
        (i) => SqliteUlaje(
              idUlaje: maps[i]['idUlaje'],
              jornada: maps[i]['jornada'],
              fecha: DateTime.tryParse(maps[i]['fecha']),
              tanque: maps[i]['tanque'],
              peso: maps[i]['peso'],
              temperatura: maps[i]['temperatura'],
              cantidadDano: maps[i]['cantidadDano'],
              descripcionDano: maps[i]['descripcionDano'],
              descripcionComentarios: maps[i]['descripcionComentarios'],
              idServiceOrder: maps[i]['idServiceOrder'],
              idUsuario: maps[i]['idUsuario'],
            ));
  }

  Future<List<SqliteUlajeTanqueFotos>> getListTanquesFotos() async {
    Database database = await openDBUlajeTanquesFotos();
    List<Map> maps = await database.query("liquidaUlajeTanquesFotos",
        columns: ["tanqueUrlFoto", "idUlaje"]);
    return List.generate(
        maps.length,
        (i) => SqliteUlajeTanqueFotos(
            tanqueUrlFoto: maps[i]['tanqueUrlFoto'],
            idUlaje: maps[i]['idUlaje']));
  }

  Future<List<SqliteUlajeObservadosFotos>> getListObservadosFotos() async {
    Database database = await openDBUlajeObservadosFotos();
    List<Map> maps = await database.query("liquidaUlajeObservadosFotos",
        columns: ["ulajeUrlFoto", "idUlaje"]);
    return List.generate(
        maps.length,
        (i) => SqliteUlajeObservadosFotos(
              ulajeUrlFoto: maps[i]['ulajeUrlFoto'],
              idUlaje: maps[i]['idUlaje'],
            ));
  }

  Future<int> clearTables() async {
    Database databaseUlaje = await openDBliquidaUlaje();
    Database dBObservadosFotos = await openDBUlajeObservadosFotos();
    Database dbtanquesFotos = await openDBUlajeTanquesFotos();
    await dBObservadosFotos.delete("liquidaUlajeObservadosFotos");
    await dbtanquesFotos.delete("liquidaUlajeTanquesFotos");
    return databaseUlaje.delete("liquidaUlaje");
  }

  Future<int> deleteUlajeByIdUlaje(int idUlaje) async {
    Database database = await openDBliquidaUlaje();

    return database
        .delete("liquidaUlaje", where: '"idUlaje"=?', whereArgs: [idUlaje]);
  }

  Future<int> deleteObservadosFotosByIdUlaje(int idUlaje) async {
    Database database = await openDBUlajeObservadosFotos();

    return database.delete("liquidaUlajeObservadosFotos",
        where: '"idUlaje"=?', whereArgs: [idUlaje]);
  }

  Future<int> deleteTanquesFotosByIDUlaje(int idUlaje) async {
    Database database = await openDBUlajeTanquesFotos();

    return database.delete("liquidaUlajeTanquesFotos",
        where: '"idUlaje"=?', whereArgs: [idUlaje]);
  }
}

class DbTanquePesosLiquidaSqlLite {
  Future<Database> openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'tanqueLiquida.db'),
        onCreate: (db, version) {
      db.execute("DROP TABLE IF EXISTS tanqueLiquida");
      return db.execute(
          "CREATE TABLE tanqueLiquida (idServiceOrder INTEGER, tanque TEXT, peso INTEGER)");
    }, version: 1);
  }

  Future<List> insertTanquePesoLiquida(
      List<VwTanquePesosLiquidaByIdServOrder>
          tanquePesosLiquidaByIdServOrder) async {
    Database database = await openDB();
    database.delete("tanqueLiquida");
    Batch batch = database.batch();
    for (int count = 0;
        count < tanquePesosLiquidaByIdServOrder.length;
        count++) {
      batch.insert("tanqueLiquida", {
        "idServiceOrder": tanquePesosLiquidaByIdServOrder[count].idServiceOrder,
        "tanque": tanquePesosLiquidaByIdServOrder[count].tanque,
        "peso": tanquePesosLiquidaByIdServOrder[count].peso,
      });
    }
    final results = await batch.commit();
    return results;
  }

  Future<List<VwTanquePesosLiquidaByIdServOrder>> listTanquePesos() async {
    Database database = await openDB();
    final List<Map<String, dynamic>> tanquePesoConsultaMap =
        await database.query(
      "tanqueLiquida",
    );
    return List.generate(
        tanquePesoConsultaMap.length,
        (i) => VwTanquePesosLiquidaByIdServOrder(
              idServiceOrder: tanquePesoConsultaMap[i]['idServiceOrder'],
              tanque: tanquePesoConsultaMap[i]['tanque'],
              peso: tanquePesoConsultaMap[i]['peso'],
            ));
  }
}
