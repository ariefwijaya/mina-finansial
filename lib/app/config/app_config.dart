import 'package:easy_localization/easy_localization.dart';
import 'package:mina_finansial/data/model/language_model.dart';

import '../config/themes.dart';

/// APP Configuration. Can be customized.
class AppConfig {
  static const String appName = "Mina Finansial";
  /// Optional Variable for development environment 
  /// `false` = production
  static const ENV_DEBUGGING = true; //false = production
  /// Default: `true`. disable this to hide any log
  static const ENABLE_LOGGING = false;

  /// Default Languages to be used
  static final LanguageModel defaultLanguage = supportedLanguageList[1];

  /// List of available langugages
  static final List<LanguageModel> supportedLanguageList = <LanguageModel>[
    LanguageModel(languageCode: 'en', countryCode: 'US', name: 'English'),
    LanguageModel(
        languageCode: 'id', countryCode: 'ID', name: 'Bahasa Indonesia'),
  ];

  /// Default Theme
  static final ThemeType defaultTheme = ThemeType.Light;
  /// Limit of data when using pagination
  static const int paginationLimit = 6;
  /// Default date format 
  static final DateFormat dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  static final DateFormat dateFormatReadable = DateFormat('d MMM yyyy');
    static final DateFormat dateFormatMonthYear = DateFormat('MMM yyyy');
  static final NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'id_ID');
}
