import 'package:mina_finansial/data/model/transaction_model.dart';

import '../../app/utils/hive_utils.dart';
import 'package:hive/hive.dart';

class TransactionDao {
  final HiveUtils dbProvider;
  TransactionDao() : dbProvider = HiveUtils(HiveBox.transaction);
  Future<Stream<BoxEvent>> streamEvent({dynamic key}) async {
    final Box db = await dbProvider.dataBox;
    return db.watch(key: key);
  }

  Future<int> create(TransactionModel data) async {
    final Box db = await dbProvider.dataBox;
    return await db.add(data.toJson());
  }

  Future<bool> update(int id, TransactionModel data) async {
    final Box db = await dbProvider.dataBox;
    await db.putAt(id, data.toJson());
    return true;
  }

  Future<void> delete(int id) async {
    final Box db = await dbProvider.dataBox;
    await db.deleteAt(id);
  }

  Future<TransactionModel> getById(int id) async {
    final db = await dbProvider.dataBox;
    final maps = db.getAt(id);
    Map<String, dynamic> castData = Map<String, dynamic>.from(maps);
    castData['category'] = Map<String, dynamic>.from(castData['category']);
    return TransactionModel.fromJson(castData);
  }

  Future<List<TransactionModel>> getRange(int start, int end) async {
    final db = await dbProvider.dataBox;
    final mapDatas = db.valuesBetween(startKey: start, endKey: end);
    List<TransactionModel> datas = <TransactionModel>[];
    mapDatas.forEach((v) {
      Map<String, dynamic> castData = Map<String, dynamic>.from(v);
      castData['category'] = Map<String, dynamic>.from(castData['category']);
      datas.add(TransactionModel.fromJson(castData));
    });
    return datas;
  }

  Future<List<TransactionModel>> getWhereDate(DateTime date) async {
    final db = await dbProvider.dataBox;
    final mapDatas = db.values.where((element) {
      Map<String, dynamic> castData = Map<String, dynamic>.from(element);
      castData['category'] = Map<String, dynamic>.from(castData['category']);
      TransactionModel transaction = TransactionModel.fromJson(castData);

      return (transaction.date!.month == date.month &&
          transaction.date!.year == date.year);
    });
    List<TransactionModel> datas = <TransactionModel>[];
    mapDatas.forEach((v) {
      Map<String, dynamic> castData = Map<String, dynamic>.from(v);
      castData['category'] = Map<String, dynamic>.from(castData['category']);
      datas.add(TransactionModel.fromJson(castData));
    });
    return datas;
  }

  Future<List<TransactionModel>> getAll() async {
    final db = await dbProvider.dataBox;
    final mapDatas = db.values;
    List<TransactionModel> datas = <TransactionModel>[];
    mapDatas.forEach((v) {
      Map<String, dynamic> castData = Map<String, dynamic>.from(v);
      castData['category'] = Map<String, dynamic>.from(castData['category']);
      datas.add(TransactionModel.fromJson(castData));
    });
    return datas;
  }

  Future<List<DateTime?>> getDateGroups() async {
    final db = await dbProvider.dataBox;
    final mapDatas = db.values;
    Set<DateTime?> uniqueDate = Set<DateTime>();
    mapDatas.forEach((v) {
      Map<String, dynamic> castData = Map<String, dynamic>.from(v);
      castData['category'] = Map<String, dynamic>.from(castData['category']);
      final date = TransactionModel.fromJson(castData).date;
      if (date != null) {
        uniqueDate.add(DateTime(date.year,date.month));
      }
    });
    final newList= uniqueDate.toList();
    newList.sort();
  return newList;
  }
}
