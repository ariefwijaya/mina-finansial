part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}


class TransactionAddEv extends TransactionEvent {
  final TransactionModel data;

  const TransactionAddEv(this.data);

  @override
  List<Object> get props => [data];
}

class TransactionDeleteEv extends TransactionEvent {
  final int id;

  const TransactionDeleteEv(this.id);

  @override
  List<Object> get props => [id];
}

class TransactionGetEv extends TransactionEvent {
  final int id;

  const TransactionGetEv(this.id);

  @override
  List<Object> get props => [id];
}

class TransactionUpdateEv extends TransactionEvent {
  final TransactionModel data;
  const TransactionUpdateEv(this.data);

  @override
  List<Object> get props => [data];
}

class TransactionListFilterMonthEv extends TransactionEvent {
  final DateTime date;

  const TransactionListFilterMonthEv(this.date);

  @override
  List<Object> get props => [date];
}

class TransactionGetAllEv extends TransactionEvent {
}

