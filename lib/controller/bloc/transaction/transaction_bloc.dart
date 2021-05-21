import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mina_finansial/data/domain/transaction_domain.dart';
import 'package:mina_finansial/data/model/transaction_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial());
  final TransactionDomain _transactionDomain = TransactionDomain();

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  Stream<TransactionState> mapEventToState(
    TransactionEvent event,
  ) async* {
    if (event is TransactionAddEv) {
      yield* _mapTransactionAddEvToState(event);
    }

    if (event is TransactionDeleteEv) {
      yield* _mapTransactionDeleteEvToState(event);
    }

    if (event is TransactionUpdateEv) {
      yield* _mapTransactionUpdateEvToState(event);
    }

    if (event is TransactionGetEv) {
      yield* _mapTransactionGetEvToState(event);
    }

    if (event is TransactionGetAllEv) {
      yield* _mapTransactionGetAllEvToState(event);
    }
  }

  Stream<TransactionState> _mapTransactionAddEvToState(
      TransactionAddEv event) async* {
    try {
      yield TransactionLoading();
      final insertId = await _transactionDomain.create(event.data);
      final finalData = event.data.copyWith(id: insertId);
      yield TransactionSuccess(data: finalData);
    } catch (e) {
      yield TransactionFailure();
    }
  }

  Stream<TransactionState> _mapTransactionDeleteEvToState(
      TransactionDeleteEv event) async* {
    try {
      yield TransactionLoading();
      await _transactionDomain.delete(event.id);
      yield TransactionDeleted(id: event.id);
    } catch (e) {
      yield TransactionFailure();
    }
  }

  Stream<TransactionState> _mapTransactionUpdateEvToState(
      TransactionUpdateEv event) async* {
    try {
      yield TransactionLoading();
      await _transactionDomain.update(event.data.id!, event.data);
      final finalData = event.data.copyWith(id: event.data.id);
      yield TransactionSuccess(data: finalData);
    } catch (e) {
      yield TransactionFailure();
    }
  }

  Stream<TransactionState> _mapTransactionGetEvToState(
      TransactionGetEv event) async* {
    try {
      yield TransactionLoading();
      final data = await _transactionDomain.getById(event.id);

      yield TransactionSuccess(data: data.copyWith(id: event.id));
    } catch (e) {
      yield TransactionFailure();
    }
  }

  Stream<TransactionState> _mapTransactionGetAllEvToState(
      TransactionGetAllEv event) async* {
    try {
      yield TransactionLoading();
      final listDate = await _transactionDomain.getDateGroups();
      List<TransactionGroupModel> datas = <TransactionGroupModel>[];
      listDate.forEach((element) async {
        print(element);
        final List<TransactionModel> transactions = element == null
            ? <TransactionModel>[]
            : await _transactionDomain.getWhereDate(element);

        datas.add(
            TransactionGroupModel(date: element, transactions: transactions));
      });

      yield TransactionListRefreshed(datas);
    } catch (e,t) {
      print(t);
      yield TransactionFailure();
    }
  }
}
