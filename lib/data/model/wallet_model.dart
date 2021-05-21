import 'package:mina_finansial/app/config/app_config.dart';

class WalletModel {
  double? total;

  String? get totalFormat {
    if (total == null) return null;
    return "${AppConfig.numberFormat.format(total)}";
  }

  WalletModel({
    this.total,
  });

  copyWith({
    double? total,
  }) {
    return WalletModel(
      total: total ?? this.total,
    );
  }

  WalletModel.fromJson(Map<String, dynamic> json) {
    dynamic jsonTotal = json['total'];
    total = jsonTotal != null && jsonTotal is int
        ? jsonTotal.toDouble()
        : jsonTotal;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    return data;
  }
}
