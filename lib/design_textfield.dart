
import 'package:flutter/material.dart';
import 'app_color.dart';

enum DesignTextfieldType { outlined, underline, none }

class DesignTextfield extends StatefulWidget {
  const DesignTextfield({
    super.key,
    this.type = DesignTextfieldType.outlined,
    this.required = false,
    this.textEditingController,
    this.onChanged,
    this.onSubmitted,
    this.hintText,
    this.labelText,
    this.errorText,
    this.maxLines,
    this.keyboardType,
    this.focusNode,
    this.prefix,
    this.suffix,
    this.enabled,
    this.obscureText = false,
    this.textAlignVertical,
    this.textInputAction,
    this.onHideText,
  });

  final DesignTextfieldType type;
  final bool required;
  final TextEditingController? textEditingController;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final Widget? prefix;
  final Widget? suffix;
  final bool? enabled;
  final bool obscureText;
  final TextAlignVertical? textAlignVertical;
  final TextInputAction? textInputAction;
  final void Function(bool)? onHideText;

  @override
  State<DesignTextfield> createState() => _DesignTextfieldState();
}

class _DesignTextfieldState extends State<DesignTextfield> {
  final _obscureNotifier = ValueNotifier(false);

  @override
  void initState() {
    if (widget.obscureText) _obscureNotifier.value = true;
    super.initState();
  }

  InputBorder get _border => switch (widget.type) {
    DesignTextfieldType.outlined => OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColor.neutral[500]!),
      borderRadius: BorderRadius.circular(12),
    ),
    DesignTextfieldType.underline => UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColor.neutral[500]!),
    ),
    DesignTextfieldType.none => InputBorder.none,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.labelText!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.required)
                  TextSpan(
                    text: " *",
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
        ],
        ValueListenableBuilder(
          valueListenable: _obscureNotifier,
          builder:
              (context, obscure, _) => TextField(
            enabled: widget.enabled,
            focusNode: widget.focusNode,
            textAlignVertical: widget.textAlignVertical,
            controller: widget.textEditingController,
            style: theme.textTheme.bodyMedium,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            obscureText: obscure,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: _border,
              enabledBorder: _border,
              disabledBorder: _border,
              focusedBorder: _border.copyWith(
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColor.primaryColor,
                ),
              ),
              errorBorder: _border.copyWith(
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColor.danger,
                ),
              ),
              focusedErrorBorder: _border.copyWith(
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColor.primaryColor,
                ),
              ),
              hintText: widget.hintText,
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: AppColor.neutral[400],
              ),
              errorText: widget.errorText,
              errorStyle: theme.textTheme.bodyMedium?.copyWith(
                color: AppColor.danger,
              ),
              prefixIcon: widget.prefix,
              suffixIcon:
              widget.obscureText
                  ? IconButton(
                onPressed: () {
                  _obscureNotifier.value = !_obscureNotifier.value;
                  widget.onHideText?.call(_obscureNotifier.value);
                },
                icon: Icon(
                  obscure ? Icons.visibility : Icons.visibility_off,
                  color: AppColor.primaryColor,
                ),
              )
                  : widget.suffix,
            ),
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            maxLines: widget.maxLines,
          ),
        ),
      ],
    );
  }
}
