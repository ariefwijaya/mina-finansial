import 'package:flutter/material.dart';
import 'package:mina_finansial/app/config/themes.dart';
import 'package:mina_finansial/app/utils/assets_utils.dart';
import 'package:mina_finansial/data/model/transaction_model.dart';
import 'package:mina_finansial/views/component/common_widget.dart';

class TileWalletWidget extends StatelessWidget {
  final String title;
  final String balance;
  const TileWalletWidget({Key? key, required this.title, required this.balance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
          child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AssetsUtils.iconWallet))),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 14,
                        color: ThemeColors.grey,
                        fontWeight: FontWeight.w400)),
                SizedBox(height: 6),
                Text(balance,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16,
                        color: ThemeColors.green80,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget buildLoader(){
    return _TileWalletWidgetLoader();
  }
}

class _TileWalletWidgetLoader extends StatelessWidget {
  const _TileWalletWidgetLoader({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
          child: Row(
        children: [ 
          ShimmerWidgetText(
            height: 40,width: 40,borderRadius: BorderRadius.circular(10),),
         
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               ShimmerWidgetText(height: 14,width: double.infinity,),
                SizedBox(height: 6),
                 ShimmerWidgetText(height: 16,width: double.infinity,),
              ],
            ),
          )
        ],
      ),
    );
  }
}




class TileTransactionWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String moneyValue;
  final String date;
  final TransactionType type;
  const TileTransactionWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.moneyValue,
      required this.date,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(this.icon))),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 12,
                        color: ThemeColors.black,
                        fontWeight: FontWeight.w500)),
                SizedBox(height: 3),
                Text(date,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 12,
                        color: ThemeColors.grey,
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          Text("${_getMoneyValueLabel()}$moneyValue",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color: _getMoneyValueColor(),
                  fontWeight: FontWeight.w500))
        ],
      ),
    );
  }

  Color _getMoneyValueColor() {
    if (type == TransactionType.income) {
      return ThemeColors.green80;
    } else if (type == TransactionType.outcome) {
      return ThemeColors.red;
    } else {
      return ThemeColors.grey;
    }
  }

  String _getMoneyValueLabel() {
    if (type == TransactionType.income) {
      return "\u002B";
    } else if (type == TransactionType.outcome) {
      return "\u2212";
    } else {
      return "";
    }
  }
}


class TileGroupWidget extends StatelessWidget {
  final String groupText;
  final List<TransactionModel> listItem;
  const TileGroupWidget({
    Key? key,required this.groupText,required this.listItem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  groupText,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(

                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                ),
              ),
              Column(
                children: 
                   listItem.map((el) => TileTransactionWidget(
                icon: (el.category?.icon)??"",
                date: el.dateFormatted!,
                moneyValue: el.totalFormat!,
                title:el.description!,
                type: el.typeEnum,
              )).toList())
            ],
          ),
        );
  }
}

