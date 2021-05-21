import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/config/app_config.dart';
import 'app/config/router.dart';
import 'app/config/themes.dart';
import 'app/utils/assets_utils.dart';
import 'controller/cubit/app/app_cubit.dart';
import 'views/screens/home/page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (AppConfig.ENABLE_LOGGING) {
    Bloc.observer = MyBlocObserver();
  }

  runApp(EasyLocalization(
      supportedLocales:
          AppConfig.supportedLanguageList.map((e) => e.toLocale()).toList(),
      path: AssetsUtils.langPath,
      startLocale: AppConfig.defaultLanguage.toLocale(),
      fallbackLocale: AppConfig.defaultLanguage.toLocale(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) =>
            context.setLocale(state.language.toLocale()),
        builder: _buildWithTheme,
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, AppState appState) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale, 
        title: AppConfig.appName,
        theme: ThemeStyle.appThemeData[appState.themeType],
        onGenerateRoute: Routes.generateRoute,
        debugShowCheckedModeBanner: false,
        home: HomePageScreen());
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc? bloc, Object? event) {
    super.onEvent(bloc!, event);
    print('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase cubit, Object error, StackTrace stackTrace) {
    print('onError -- cubit: ${cubit.runtimeType}, error: $error');
    super.onError(cubit, error, stackTrace);
  }
}
