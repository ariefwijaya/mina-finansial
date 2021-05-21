import 'package:mina_finansial/controller/bloc/transaction/transaction_bloc.dart';
import 'package:mina_finansial/views/screens/er404_screen.dart';
import 'package:mina_finansial/views/screens/home/page.dart';
import 'package:mina_finansial/views/screens/transaction_add/page.dart';

import '../utils/router_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Routes Configuration and Management
class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouterUtils.root:
        return MaterialPageRoute(builder: (_) => HomePageScreen());
      case RouterUtils.transaction_add:
        return MaterialPageRoute(
            builder: (_) => TransactionAddScreen(
            ), settings: routeSettings);
      default: //redirect to appinfoview
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, Animation<double> a1, Animation<double> a2) =>
                Er404Screen());
    }
  }
}
