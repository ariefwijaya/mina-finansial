import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mina_finansial/data/domain/transaction_domain.dart';
import 'package:mina_finansial/data/model/transaction_model.dart';
import 'package:mina_finansial/data/model/wallet_model.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial());

  final TransactionDomain _transactionDomain = TransactionDomain();

  @override
  Stream<WalletState> mapEventToState(
    WalletEvent event,
  ) async* {
    if (event is WalletFetched) {
      try {
        yield WalletLoading();
        List<TransactionModel> datas = await _transactionDomain.getAll();
        double total = 0;
        datas.forEach((element) {
          if (element.typeEnum == TransactionType.income) {
            total += element.total!;
          } else if (element.typeEnum == TransactionType.outcome) {
            total -= element.total!;
          }
        });
        yield WalletSuccess(WalletModel(total: total));
      } catch (e, t) {
        print(t);
        yield WalletFailure(error: e.toString());
      }
    }
  }
}
