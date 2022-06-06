import 'package:easy_mask/easy_mask.dart';
import 'package:farmasys/screen/mask/interface/i_mask_cpf.dart';

class MaskCpf implements IMaskCpf {
  @override
  final TextInputMask inputMask = TextInputMask(
    mask: ['999.999.999-99'],
  );
}