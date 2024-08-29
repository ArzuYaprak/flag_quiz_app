import 'package:flag_quiz_app/Flags.dart';
import 'package:flag_quiz_app/VeritabaniYardimcisi.dart';

class Flagsdao {

  Future<List<Flags>> cometorandom() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM Flags ORDER BY RANDOM() LIMIT 5");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Flags(satir["flag_id"], satir["flag_name"], satir["flag_image"]);
    });
  }
  Future<List<Flags>> cometoWrongrandom(int flag_id) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM Flags WHERE flag_id != $flag_id ORDER BY RANDOM() LIMIT 3");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Flags(satir["flag_id"], satir["flag_name"], satir["flag_image"]);
    });
  }
}



