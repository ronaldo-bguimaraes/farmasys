import 'package:easy_mask/easy_mask.dart';
import 'package:farmasys/screen/mask/interface/i_mask_telefone.dart';

class MaskTelefone implements IMaskTelefone {
  @override
  final TextInputMask inputMask = TextInputMask(
    mask: ['(99) 99999-9999', '(99) 9999-9999'],
  );
}
