import 'package:mina_finansial/app/config/app_config.dart';
import 'package:mina_finansial/app/utils/assets_utils.dart';

enum TransactionType { income, outcome, none }

class TransactionModel {
  int? id;
  double? total;
  Category? category;
  String? description;
  DateTime? date;
  String? type;

  String? get totalFormat {
    if (total == null) return null;
    return "${AppConfig.numberFormat.format(total)}";
  }

  TransactionType get typeEnum {
    if (type == "+") {
      return TransactionType.income;
    } else if (type == "-") {
      return TransactionType.outcome;
    } else {
      return TransactionType.none;
    }
  }

  static String getTypeByEnum(TransactionType typeEnums) {
    if (typeEnums == TransactionType.income) {
      return "+";
    } else if (typeEnums == TransactionType.outcome) {
      return "-";
    } else {
      return "";
    }
  }

  String? get dateFormatted {
    if (date == null) return null;
    return AppConfig.dateFormatReadable.format(date!);
  }

  TransactionModel(
      {this.id,
      this.total,
      this.category,
      this.description,
      this.date,
      this.type});

  copyWith(
      {int? id,
      double? total,
      Category? category,
      String? description,
      DateTime? date,
      String? type}) {
    return TransactionModel(
        id: id ?? this.id,
        total: total ?? this.total,
        category: category ?? this.category,
        description: description ?? this.description,
        date: date ?? this.date,
        type: type ?? this.type);
  }

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dynamic jsonTotal = json['total'];
    total = jsonTotal != null && jsonTotal is int
        ? jsonTotal.toDouble()
        : jsonTotal;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    description = json['description'];
    date = json['date'] != null ? DateTime.parse(json['date']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['category'] = this.category?.toJson();
    data['description'] = this.description;
    data['date'] =
        this.date != null ? AppConfig.dateTimeFormat.format(this.date!) : null;
    data['type'] = this.type;
    return data;
  }
}

class TransactionGroupModel {
  DateTime? date;
  List<TransactionModel>? transactions = [];

  TransactionGroupModel({this.date, this.transactions});

  String? get dateFormatted {
    if (date == null) return null;
    return AppConfig.dateFormatMonthYear.format(date!);
  }

  TransactionGroupModel.fromJson(Map<String, dynamic> json) {
    date = json['date'] != null ? DateTime.parse(json['date']) : null;

    if (json['transactions'] != null) {
      transactions = <TransactionModel>[];
      json['transactions'].forEach((v) {
        transactions?.add(new TransactionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] =
        this.date != null ? AppConfig.dateTimeFormat.format(this.date!) : null;

    if (this.transactions != null) {
      data['transactions'] = this.transactions?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? icon;

 @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;


  Category({this.id, this.name, this.icon});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    return data;
  }

  static List<Category> getAvailableList() {
    return <Category>[
      Category(id: 1, name: "Pendidikan", icon: AssetsUtils.iconPendidikan),
      Category(id: 2, name: "Penghasilan", icon: AssetsUtils.iconPemasukan),
      Category(id: 3, name: "Belanja", icon: AssetsUtils.iconBelanja),
    ];
  }
}
