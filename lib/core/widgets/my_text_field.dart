import 'package:tracker/utils/tracker_path_export.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;

  final Function()? onTap;

  const MyTextField({
    Key? key,
    required this.hintText,
    required this.inputType,
    this.validator,
    this.autoValidateMode,
    this.controller,
    this.maxLength,
    this.maxLines,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onTap:onTap,
        maxLines:maxLines??1 ,
        maxLength: maxLength,
        controller: controller,
        autovalidateMode: autoValidateMode ?? AutovalidateMode.disabled,
        validator: (value) {
          if (validator != null) {
            return validator!(value);
          }
          return null;
        },
        style: TrackerTextStyles.kLabelSmall.copyWith(color: Colors.white),
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: TrackerTextStyles.kLabelSmall,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red.shade400,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red.shade400,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
