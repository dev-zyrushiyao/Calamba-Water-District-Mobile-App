import 'package:flutter/material.dart';

class FormEditableTextfield extends StatefulWidget {
  const FormEditableTextfield({
    super.key,
    required this.loggedUserValues,
    required this.textController,
    required this.textSection,
    this.maxLength,
    required this.validator,
    required this.onChanged,
    required this.onSaved,
    this.isHidden = false,
    required this.textInputType,
  });

  final dynamic loggedUserValues;
  final TextEditingController textController;
  final String textSection;
  final int? maxLength;
  final String? Function(String? value)? validator;
  final void Function(String value)? onChanged;
  final void Function(String? value)? onSaved;
  final bool isHidden;
  final TextInputType textInputType;

  @override
  State<FormEditableTextfield> createState() => _FormEditableTextfieldState();
}

class _FormEditableTextfieldState extends State<FormEditableTextfield> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return TextFormField(
      maxLength: widget.maxLength,
      controller: widget.textController,
      keyboardType: widget.textInputType,
      textInputAction: TextInputAction.done,
      obscureText: widget.isHidden,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      decoration: InputDecoration(
        label: Text(widget.textSection),
        helperStyle: theme.textTheme.labelSmall!.copyWith(
          color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
        ),
        errorStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
}
