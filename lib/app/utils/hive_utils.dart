import 'package:hive/hive.dart';
///List of available Box
class HiveBox {
  ///User Box
  static final String transaction = 'transaction';
  static final String appconfig = 'appconfig';
}

///Utils method for Hive.
class HiveUtils {
  late Box _box;
  late String _boxName;
  HiveUtils(String boxName)
      : _boxName = boxName;

  Future<Box> get dataBox async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox(_boxName);
    }else{
      _box = Hive.box(_boxName);
    }
    return _box;
  }

}
