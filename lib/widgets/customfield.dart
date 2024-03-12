import 'package:weather/enums/text_field_type_enum.dart';
import 'package:weather/style/appColors.dart';
import 'package:weather/utils/constvalues.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class CustomField extends ConsumerWidget {
  const CustomField(
      {Key? key,
      this.hint = '',
      this.width,
      this.height,
      this.sIcon,
      this.pIcon,
      this.obscureText = false,
      this.isWordField = true,
      this.maxline,
      this.controller,
      this.contentPadding,
      this.onChanged,
      this.hintstyle,
      this.hintColor,
      this.headtext,
      this.keyboardType,
      this.validate = true,
      this.readonly = false,
      this.autoFocus = false,
      this.fieldType,
      this.onTap,
      this.maxLength,
      this.useNativeKeyboard = true,
      this.inputDecoration,
      this.fillColor,
      this.onCompleted,
      this.border,
      this.enabledBorder,
      this.focusedBorder,
      this.pinPutFocusNode,
      this.style,
      this.focusNode,
      this.pinBorderColor,
      this.pinPutFieldCount,
      this.textInputFormatters,
      this.shape = BoxShape.rectangle,
      this.mainAxisAlignment,
      this.showPinPrefilledWidget = true,
      this.obscuringCharacter,
      this.validator})
      : super(key: key);

  final Function(String)? onCompleted;
  final String hint;
  final FocusNode? pinPutFocusNode;
  final Color? fillColor;
  final bool useNativeKeyboard;
  final double? width;
  final double? height;
  final Widget? sIcon;
  final Widget? pIcon;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final InputDecoration? inputDecoration;
  final Function? validator;
  final Function? onTap;
  final TextStyle? hintstyle;
  final Color? hintColor;
  final int? maxline;
  final String? headtext;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextFieldType? fieldType;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final bool isWordField;
  final bool validate;
  final bool readonly;
  final Color? pinBorderColor;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final bool autoFocus;
  final BoxShape? shape;
  final TextStyle? style;
  final int? pinPutFieldCount;
  final MainAxisAlignment? mainAxisAlignment;
  final bool showPinPrefilledWidget;
  final String? obscuringCharacter;
  final List<TextInputFormatter>? textInputFormatters;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: fillColor ?? Theme.of(context).inputDecorationTheme.fillColor,
      shape: shape ?? BoxShape.rectangle,
      border: Border.all(
          color: pinBorderColor ?? AppColors.termsTextColor.withOpacity(0.5),
          width: 1.w),
      borderRadius:
          shape == BoxShape.circle ? null : BorderRadius.circular(10.0),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // headtext == null
        //     ? const SizedBox.shrink()
        //     : Text(headtext!,
        //         style: Theme.of(context)
        //             .primaryTextTheme
        //             .headlineMedium!
        //             .copyWith(fontSize: 13)),
        // const SizedBox(
        //   height: 10,
        // ),
        Expanded(
          flex: 0,
          //height: inputFieldHeight,
          child: SizedBox(
              width: width,
              height: height,
              child: isWordField
                  ? TextFormField(
                      onTap: readonly == true
                          ? () {
                              onTap!();
                            }
                          : null,
                      maxLines: maxline ?? 1,
                      maxLength: maxLength,
                      obscureText: obscureText,
                      controller: controller,
                      readOnly: readonly,
                      autofocus: false,
                      focusNode: focusNode,
                      scrollPadding:
                          EdgeInsets.only(bottom: keyboardHeight + 20),
                      enableSuggestions: true,
                      keyboardType: fieldType == TextFieldType.phone
                          ? TextInputType.phone
                          : keyboardType ?? TextInputType.text,
                      onChanged: onChanged,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headlineMedium!
                          .copyWith(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                      inputFormatters: textInputFormatters,
                      decoration: InputDecoration(
                        fillColor: fillColor,
                        filled: true,
                        focusColor: fillColor,
                        enabledBorder: enabledBorder ??
                            OutlineInputBorder(
                                borderSide:  BorderSide(
                                    color: AppColors.termsTextColor.withOpacity(0.4), width: 1),
                                borderRadius: BorderRadius.circular(10)),
                        focusedBorder: focusedBorder ??
                            OutlineInputBorder(
                                borderSide:  BorderSide(
                                    color: AppColors.termsTextColor.withOpacity(0.4), width: 1),
                                borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(
                            borderSide:  const BorderSide(
                                color: AppColors.primary, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide:  const BorderSide(
                                color: AppColors.primary, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        border: border,
                        contentPadding: contentPadding,
                        errorMaxLines: 6,
                        labelText: headtext,
                        prefixIcon: pIcon,
                        suffixIcon: sIcon,
                       // hintText: hint,
                        labelStyle: hintstyle ??
                            Theme.of(context)
                                .primaryTextTheme
                                .headlineMedium
                                ?.copyWith(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .headlineMedium
                                        ?.color!
                                        .withOpacity(0.7)),
                      ),
                      validator: (val) {
                        if (fieldType == TextFieldType.refferal) return null;
                        if (val == null) return 'Invalid input';
                        if (validator == null) {
                          if (fieldType == TextFieldType.bvn) {
                            if (val.isEmpty) {
                              return 'Field cannot be empty';
                            } else if (val.trim().isEmpty) {
                              return "Field cannot be empty";
                            } else if (val.length < 11) {
                              return 'Invalid Entry';
                            } else if (int.tryParse(val) == null) {
                              return 'Invalid entry';
                            }
                            return null;
                          } else if (fieldType == TextFieldType.accountNo) {
                            if (val.isEmpty) {
                              return 'Field cannot be empty';
                            } else if (val.trim().isEmpty) {
                              return "Field cannot be empty";
                            } else if (val.length < 10) {
                              return 'Invalid Entry';
                            } else if (int.tryParse(val) == null) {
                              return 'Invalid entry';
                            }
                            return null;
                          } else if (fieldType == TextFieldType.pin) {
                            if (val.isEmpty) {
                              return 'Field cannot be empty';
                            } else if (val.trim().isEmpty) {
                              return "Field cannot be empty";
                            } else if (val.length < 4) {
                              return 'Invalid Entry';
                            } else if (int.tryParse(val) == null) {
                              return 'Invalid entry';
                            }
                            return null;
                          } else if (fieldType == TextFieldType.phone) {
                            if (val.isEmpty || val.trim().isEmpty) {
                              return 'Field must not be empty';
                            } else if (val.length < phoneNumberFieldLength) {
                              return 'Invalid entry';
                            } else if (int.tryParse(val.replaceAll('+', '')) ==
                                null) {
                              return 'Invalid entry';
                            }
                            return null;
                          } else {
                            if (validate) {
                              if (val.isEmpty &&
                                  (fieldType != TextFieldType.pin)) {
                                return "Field cannot be empty";
                              } else if (val.trim().isEmpty) {
                                return "Field cannot be empty";
                              } else if (fieldType == TextFieldType.amount) {
                                if (double.tryParse(val.replaceAll(',', '')) ==
                                    null) {
                                  return 'Enter a valid amount';
                                } else if (double.tryParse(
                                        val.replaceAll(',', ''))! <=
                                    0) {
                                  return 'Enter a valid amount';
                                }
                              } else if (fieldType == TextFieldType.email) {
                                bool isValidEmail = RegExp(
                                        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                    .hasMatch(val);
                                return isValidEmail
                                    ? null
                                    : "Please provide a valid email address";
                              }  else if (fieldType == TextFieldType.nin) {
                                if (val.isEmpty || val.trim().isEmpty) {
                                  return 'Field must not be empty';
                                } else if (val.length < 11) {
                                  return 'Invalid entry';
                                } else if (int.tryParse(val) == null) {
                                  return 'Invalid entry';
                                }
                                return null;
                              }
                            }

                            return null;
                          }
                        } else {
                          validator!(val);
                        }
                        return null;
                      },
                    )
                  : Theme(
                      data: Theme.of(context).copyWith(
                          inputDecorationTheme: const InputDecorationTheme(
                        filled: false,
                      )),
                      child: Pinput(
                          length: pinPutFieldCount! > 0
                              ? pinPutFieldCount!.toInt()
                              : pinCodeFieldLength,
                          validator: (val) {
                            if (val == null) return 'Invalid input';
                            if (pinPutFieldCount! < 1
                                ? val.length < pinCodeFieldLength
                                : val.length < pinPutFieldCount!) {
                              return 'Complete the Pin Fields';
                            }
                            return null;
                          },
                          closeKeyboardWhenCompleted: true,
                          keyboardType: TextInputType.phone,
                          errorTextStyle: Theme.of(context)
                              .primaryTextTheme
                              .headlineMedium
                              ?.copyWith(
                                  color: AppColors.primary, fontSize: 11.sp),
                          defaultPinTheme: PinTheme(
                              width: width ?? 45,
                              height: height ?? 45,
                              textStyle: Theme.of(context)
                                  .primaryTextTheme
                                  .headlineMedium!
                                  .copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w300),
                              decoration: pinPutDecoration),
                          onCompleted: onCompleted,
                          obscuringCharacter: obscuringCharacter ?? '*', //●
                          mainAxisAlignment:
                              mainAxisAlignment ?? MainAxisAlignment.center,
                          obscureText: true,
                          controller: controller,
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          autofocus: autoFocus,
                          focusNode: pinPutFocusNode,
                          preFilledWidget: showPinPrefilledWidget
                              ? Container(
                                  height: 35,
                                  width: 35,
                                  decoration: const BoxDecoration(
                                      // border: Border(
                                      //     bottom: BorderSide(
                                      //         width: 1.5,
                                      //         color: AppColors.termsTextColor.withOpacity(0.4))
                                      //         )
                                      ),
                                )
                              : null),
                    )),
        )
      ],
    );
  }
}
