part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {
  final TransactionModel? data;

  const TransactionSuccess({this.data});

  @override
  List<Object> get props => [data!];
}

class TransactionDeleted extends TransactionState {
  final int? id;

  const TransactionDeleted({this.id});

  @override
  List<Object> get props => [id!];
}

class TransactionFailure extends TransactionState {
  final String? error;

  const TransactionFailure({this.error});

  @override
  List<Object> get props => [error??""];
}

class TransactionListRefreshed extends TransactionState {
  final List<TransactionGroupModel> datas;

  const TransactionListRefreshed(this.datas);

  @override
  List<Object> get props => [datas];
}
