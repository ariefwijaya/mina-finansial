import 'package:flutter/material.dart';
import 'package:mina_finansial/app/config/themes.dart';
import 'package:mina_finansial/app/utils/assets_utils.dart';
import 'package:mina_finansial/data/model/transaction_model.dart';
import 'package:mina_finansial/views/component/common_widget.dart';
import 'package:mina_finansial/views/screens/home/component.dart';

import 'component.dart';

class TransactionAddScreen extends StatefulWidget {
  const TransactionAddScreen({Key? key}) : super(key: key);

  @override
  _TransactionAddScreenState createState() => _TransactionAddScreenState();
}

class _TransactionAddScreenState extends State<TransactionAddScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: Stack(children: [
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
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            )
          ],
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 35.78,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  TitlePageWidget(
                    title: "Buat Transaksi",
                  ),
                  CustomCardWidget(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TabBar(
                      unselectedLabelColor: ThemeColors.grey,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.white),
                      unselectedLabelStyle: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ThemeColors.grey),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Theme.of(context).primaryColor),
                      tabs: [
                        Tab(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text("Pengeluaran"),
                        )),
                        Tab(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text("Pemasukan"),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  TransactionAddBody(
                    type: TransactionType.outcome,
                  ),
                  TransactionAddBody(type: TransactionType.income),
                ],
              ),
            ),
          ],
        ),
      ])),
    );
  }
}
