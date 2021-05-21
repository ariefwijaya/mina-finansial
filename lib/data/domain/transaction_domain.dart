import 'package:mina_finansial/data/dao/transaction_dao.dart';
import 'package:mina_finansial/data/model/transaction_model.dart';
import 'package:hive/hive.dart';

class TransactionDomain {
  final TransactionDao _transactionDao = TransactionDao();

  Future<Stream<BoxEvent>> streamEvent({dynamic key}) {
    return _transactionDao.streamEvent(key: key);
  }

  Future<int> create(TransactionModel data) {
    return _transactionDao.create(data);
  }

  Future<bool> update(int id, TransactionModel data) {
    return _transactionDao.update(id, data);
  }

  Future<void> delete(int id) {
    return _transactionDao.delete(id);
  }

  Future<TransactionModel> getById(int id) {
    return _transactionDao.getById(id);
  }

  Future<List<TransactionModel>> getRange(int start, int end) {
    return _transactionDao.getRange(start, end);
  }

  Future<List<TransactionModel>> getWhereDate(DateTime date)  {
    return _transactionDao.getWhereDate(date);
  }

  Future<List<TransactionModel>> getAll()  {
    return _transactionDao.getAll();
  }

   Future<List<DateTime?>> getDateGroups()  {
    return _transactionDao.getDateGroups();
  }
}
