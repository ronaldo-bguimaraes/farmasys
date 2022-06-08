import 'package:easy_mask/easy_mask.dart';
import 'package:farmasys/screen/mask/interface/i_mask_date.dart';

class MaskDate implements IMaskDate {
  @override
  final TextInputMask inputMask = TextInputMask(
    mask: ['99/99/9999'],
  );
}
