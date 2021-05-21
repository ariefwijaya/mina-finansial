import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_finansial/app/config/app_config.dart';
import 'package:mina_finansial/app/config/themes.dart';
import 'package:mina_finansial/app/utils/assets_utils.dart';
import 'package:flutter/material.dart';
import 'package:mina_finansial/app/utils/router_utils.dart';
import 'package:mina_finansial/controller/bloc/transaction/transaction_bloc.dart';
import 'package:mina_finansial/controller/bloc/wallet/wallet_bloc.dart';
import 'package:mina_finansial/views/component/common_button.dart';
import 'package:mina_finansial/views/component/common_widget.dart';

import 'component.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  TransactionBloc _transactionBloc = TransactionBloc();
  WalletBloc _walletBloc = WalletBloc();
  @override
  void initState() {
    _transactionBloc = TransactionBloc()..add(TransactionGetAllEv());
    _walletBloc = WalletBloc()..add(WalletFetched());
    super.initState();
  }

  @override
  void dispose() {
    _transactionBloc.close();
    _walletBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TransactionBloc>(create: (context) => _transactionBloc),
        BlocProvider<WalletBloc>(create: (context) => _walletBloc)
      ],
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.sync(() {
            _transactionBloc.add(TransactionGetAllEv());
            _walletBloc.add(WalletFetched());
          });
        },
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Flexible(
                    child: Container(
                      height: 173,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(AssetsUtils.headerbg1))),
                    ),
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  )
                ],
              ),
              CustomScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                      child: Container(
                    margin: EdgeInsets.only(top: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 24),
                          child: CButtonFilled(
                            textLabel: "Set Transaksi",
                            icon: Icon(Icons.add, color: ThemeColors.blackNavy),
                            mini: true,
                            primaryColor: Colors.white,
                            onPressed: () async {
                              final res = await Navigator.pushNamed(
                                  context, RouterUtils.transaction_add,
                                  arguments: _transactionBloc);
                              if (res != null) {
                                _transactionBloc.add(TransactionGetAllEv());
                                _walletBloc.add(WalletFetched());
                              }
                            },
                          ),
                        ),
                        TitlePageWidget(
                          title: "Catat Transaksi",
                        ),
                        BlocBuilder<WalletBloc, WalletState>(
                          bloc: _walletBloc,
                          builder: (context, state) {
                            if (state is WalletSuccess) {
                              return TileWalletWidget(
                                title: "Status Keuanganku",
                                balance: state.balance.totalFormat!,
                              );
                            }

                            if (state is WalletFailure) {
                              return GestureDetector(
                                onTap: () {
                                  _walletBloc.add(WalletFetched());
                                },
                                child: TileWalletWidget(
                                  title: "Status Keuanganku",
                                  balance: "Failed, Tap to Refresh",
                                ),
                              );
                            }

                            return TileWalletWidget.buildLoader();
                          },
                        )
                      ],
                    ),
                  )),
                  BlocBuilder<TransactionBloc, TransactionState>(
                      bloc: _transactionBloc,
                      builder: (context, state) {
                        if (state is TransactionListRefreshed) {
                          if (state.datas.length == 0) {
                            return SliverToBoxAdapter(
                                child: PlaceholderWidget(
                              mainAxisAlignment: MainAxisAlignment.center,
                              title: "You have no Transactions :(",
                              subtitle: "Let's add a new one",
                              imagePath: AssetsUtils.emptyStreet,
                            ));
                          }
                          return SliverList(
                              delegate: SliverChildListDelegate(state.datas
                                  .map((el) => TileGroupWidget(
                                        groupText: el.dateFormatted!,
                                        listItem: el.transactions!,
                                      ))
                                  .toList()));
                        }

                        if (state is TransactionFailure) {
                          return SliverToBoxAdapter(
                              child: PlaceholderWidget(
                            mainAxisAlignment: MainAxisAlignment.center,
                            title: "Oops, Error happened",
                            subtitle: "Please retry",
                            buttonText: "Retry",
                            onPressed: () {
                              _transactionBloc.add(TransactionGetAllEv());
                            },
                          ));
                        }

                        return SliverToBoxAdapter(child: Container());
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
