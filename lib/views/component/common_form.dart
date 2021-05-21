import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mina_finansial/app/config/themes.dart';

class CFilledTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;

  const CFilledTextField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      this.onSaved,
      this.validator,
      this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ThemeColors.blackLight),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          inputFormatters: [],
          keyboardType: textInputType,
          onSaved: onSaved,
          validator: validator,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: ThemeColors.greyLight, style: BorderStyle.solid),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: ThemeColors.greyLight, style: BorderStyle.solid),
              ),
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ThemeColors.grey30),
              fillColor: ThemeColors.whiteGrey,
              filled: true),
        ),
      ],
    );
  }
}

class CFilledDateField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final Function(DateTime?)? onSaved;
  final String? Function(DateTime?)? validator;
  final DateTime? initialDate;
  final DateFormat? dateFormat;

  const CFilledDateField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      this.onSaved,
      this.validator,
      this.initialDate,
      this.dateFormat})
      : super(key: key);

  @override
  _CFilledDateFieldState createState() => _CFilledDateFieldState();
}

class _CFilledDateFieldState extends State<CFilledDateField> {
  DateFormat? _dateFormat;
  TextEditingController? controller;
  DateTime? selectedTime;
  @override
  void initState() {
    _dateFormat = widget.dateFormat ?? DateFormat("dd/MM/yyyy");
    controller = new TextEditingController(
        text: widget.initialDate != null
            ? _dateFormat?.format(widget.initialDate!)
            : null);
            selectedTime = widget.initialDate ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ThemeColors.blackLight),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: controller,
          onTap: () async {
            // Below line stops keyboard from appearing
            FocusScope.of(context).requestFocus(new FocusNode());

            // Show Date Picker Here
            final chosenDate = await showDatePicker(
                context: context,
                initialDate: selectedTime??widget.initialDate ?? DateTime.now(),
                firstDate: DateTime(2019),
                lastDate: DateTime.now());

            if (chosenDate != null) {
              controller?.text = _dateFormat!.format(chosenDate);
              selectedTime = chosenDate;
            }
          },
          onSaved: (val) {
            widget.onSaved?.call(selectedTime);
          },
          validator: (val) {
            return widget.validator?.call(selectedTime);
          },
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.arrow_drop_down,
                size: 30,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: ThemeColors.greyLight, style: BorderStyle.solid),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: ThemeColors.greyLight, style: BorderStyle.solid),
              ),
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ThemeColors.grey30),
              fillColor: ThemeColors.whiteGrey,
              filled: true),
        ),
      ],
    );
  }
}

class CFilledDropdownField<T> extends StatefulWidget {
  final String labelText;
  final String hintText;
  final Function(T?)? onSaved;
  final String? Function(T?)? validator;
  final List<DropdownMenuItem<T>>? listItem;

  const CFilledDropdownField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      this.onSaved,
      this.validator,
      this.listItem})
      : super(key: key);

  @override
  _CFilledDropdownFieldState<T> createState() =>
      _CFilledDropdownFieldState<T>();
}

class _CFilledDropdownFieldState<T> extends State<CFilledDropdownField<T>> {
  T? selected;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ThemeColors.blackLight),
        ),
        SizedBox(
          height: 8,
        ),
        DropdownButtonFormField<T>(
            value: selected,
            onChanged: (val) {
              setState(() {
                selected = val;
              });
            },
            validator: widget.validator,
            onSaved: widget.onSaved,
            itemHeight: 50,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: ThemeColors.greyLight, style: BorderStyle.solid),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: ThemeColors.greyLight, style: BorderStyle.solid),
                ),
                hintText: widget.hintText,
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors.grey30),
                fillColor: ThemeColors.whiteGrey,
                filled: true),
            items: widget.listItem),
      ],
    );
  }
}
