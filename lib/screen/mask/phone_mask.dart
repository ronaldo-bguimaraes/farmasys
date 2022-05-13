import 'package:easy_mask/easy_mask.dart';

TextInputMask getPhoneMask() {
  return TextInputMask(
    mask: ['(99) 99999-9999', '(99) 9999-9999'],
  );
}
