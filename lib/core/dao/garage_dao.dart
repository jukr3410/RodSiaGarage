import 'package:rodsiagarage/core/database/garage_database.dart';
import 'package:rodsiagarage/core/models/garage_model_db.dart';

class GarageDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createGarage(GarageDB garage) async {
    final db = await dbProvider.database;

    var result = db.insert(garageTable, garage.toDatabaseJson());
    return result;
  }

  Future<int> deleteGarage(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(garageTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<bool> checkGarage(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> garages =
          await db.query(garageTable, where: 'id = ?', whereArgs: [id]);
      if (garages.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
