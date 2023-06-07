import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/control_reestibas_model/registro_reestibas_model.dart';

class DBControlReestibas {
  Future<Database> openDbRegistroReestibas() async {
    return openDatabase(join(await getDatabasesPath(), 'registroReestibas.db'),
        onCreate: (db, version) {
      db.execute("DROP TABLE IF EXISTS registroReestibas");
      return db.execute(
          "CREATE TABLE registroReestibas (idRegistroReestibas INTEGER PRIMARY KEY, marca TEXT, modelo TEXT, cantidad Integer, pesoBruto REAL, unidad TEXT, nivelInicial TEXT, bodegaInicial TEXT, comentarios TEXT)");
    }, version: 1);
  }

  Future<int> insertRegistroReestibas(
      RegistroReestibasModel registroReestibasModel) async {
    Database database = await openDbRegistroReestibas();

    final result = database.insert(
        "registroReestibas", registroReestibasModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<List<RegistroReestibasModel>> getRegistroReestibasList() async {
    Database database = await openDbRegistroReestibas();
    List<Map> maps = await database.query("registroReestibas", columns: [
      "idRegistroReestibas",
      "marca",
      "modelo",
      "cantidad",
      "pesoBruto",
      "unidad",
      "nivelInicial",
      "bodegaInicial",
    ]);
    return List.generate(
        maps.length,
        (i) => RegistroReestibasModel(
              idRegistroReestibas: maps[i]['idRegistroReestibas'],
              marca: maps[i]['marca'],
              modelo: maps[i]['modelo'],
              cantidad: maps[i]['cantidad'],
              pesoBruto: maps[i]['pesoBruto'],
              unidad: maps[i]['unidad'],
              nivelInicial: maps[i]['nivelInicial'],
              bodegaInicial: maps[i]['bodegaInicial'],
            ));
  }
}
