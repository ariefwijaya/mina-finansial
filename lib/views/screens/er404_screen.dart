import 'package:easy_localization/easy_localization.dart';
import 'package:mina_finansial/app/utils/assets_utils.dart';
import 'package:mina_finansial/generated/lang_utils.dart';
import 'package:mina_finansial/views/component/common_widget.dart';
import 'package:flutter/material.dart';

class Er404Screen extends StatelessWidget {
  const Er404Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: PlaceholderWidget(
         mainAxisAlignment: MainAxisAlignment.center,
        title: LocaleKeys.error_404_title.tr(),
        subtitle: LocaleKeys.error_404_subtitle.tr(),
        imagePath: AssetsUtils.emptyStreet,
      ),
    );
  }
}