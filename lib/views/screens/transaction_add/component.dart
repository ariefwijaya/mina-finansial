import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_finansial/app/config/themes.dart';
import 'package:mina_finansial/app/utils/assets_utils.dart';
import 'package:mina_finansial/controller/bloc/transaction/transaction_bloc.dart';
import 'package:mina_finansial/data/model/transaction_model.dart';
import 'package:mina_finansial/views/component/common_button.dart';
import 'package:mina_finansial/views/component/common_form.dart';
import 'package:mina_finansial/views/component/common_widget.dart';

class TransactionAddBody extends StatefulWidget {
  final TransactionType? type;
  const TransactionAddBody({Key? key, this.type}) : super(key: key);

  @override
  _TransactionAddBodyState createState() => _TransactionAddBodyState();
}

class _TransactionAddBodyState extends State<TransactionAddBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TransactionModel _transactionModel = TransactionModel();
  TransactionBloc _transactionBloc = TransactionBloc();

  @override
  void initState() {
    _transactionModel =
        TransactionModel(type: TransactionModel.getTypeByEnum(widget.type!));
    _transactionBloc = TransactionBloc();
    super.initState();
  }

  @override
  void dispose() {
    _transactionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionBloc>(
      create: (context) => _transactionBloc,
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: BlocConsumer<TransactionBloc, TransactionState>(
            bloc: _transactionBloc,
            listener: (context, state) {
              if (state is TransactionFailure) {
                FlushbarHelper.createError(
                    message: "Terjadi kesalahan ketika menyimpan transaksi")
                  ..show(context);
              }

              if (state is TransactionSuccess) {
                FlushbarHelper.createSuccess(message: "Berhasil disimpan")
                  ..show(context).then((value) => Navigator.pop(context,true));
              }
            },
            builder: (context, state) {
              bool isLoading = false;
              bool isDisabled = false;
              if (state is TransactionLoading) {
                isLoading = true;
              }
              if (state is TransactionSuccess) {
                isDisabled = true;
              }
              return SingleChildScrollView(
                child: CustomCardWidget(
                  child: Column(
                    children: [
                      CFilledTextField(
                        labelText: "Jumlah",
                        hintText: "Rp999,999",
                        textInputType: TextInputType.number,
                        onSaved: (val) =>
                            _transactionModel.total = double.tryParse(val!),
                        validator: (val) =>
                            val!.isEmpty ? "Data harus dimasukkan" : null,
                      ),
                      SizedBox(height: 16),
                      CFilledDropdownField<Category>(
                          labelText: "Pilih Kategori",
                          hintText: "Lihat Kategori",
                          onSaved: (val) => _transactionModel.category=val,
                          validator: (val) =>
                              val == null ? "Data Harus dimasukkan" : null,
                          listItem: Category.getAvailableList()
                              .map((e) => DropdownMenuItem<Category>(
                                  child: Text(
                                    e.name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: ThemeColors.blackNavy),
                                  ),
                                  value: e))
                              .toList()),
                      SizedBox(height: 16),
                      CFilledDateField(
                        initialDate: _transactionModel.date,
                        labelText: "Tanggal",
                        hintText: "dd/mm/yyyy",
                        onSaved: (val) => _transactionModel.date = val,
                        validator: (val) =>
                            val == null ? "Data harus dimasukkan" : null,
                      ),
                      SizedBox(height: 16),
                      CFilledTextField(
                        labelText: "Keterangan",
                        hintText: "Komentar",
                        onSaved: (val) => _transactionModel.description = val,
                        validator: (val) =>
                            val!.isEmpty ? "Data harus dimasukkan" : null,
                      ),
                      SizedBox(height: 16),
                      Container(
                          width: double.infinity,
                          child: CButtonFilled(
                            textColor: Colors.white,
                            isLoading: isDisabled?false:isLoading,
                            textLabel: "Simpan",
                            onPressed: isDisabled
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      _transactionBloc.add(
                                          TransactionAddEv(_transactionModel));
                                    }
                                  },
                          ))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
