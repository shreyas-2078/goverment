
import 'package:goverment_online/utils/constants/regex_strings.dart';
import 'package:goverment_online/utils/constants/validator_error_msg.dart';

class Validations {
      const Validations._();

  String? validationForEmail(String? value) {
    if (value == null || value.isEmpty) {
      return ValidatorErrorMsg.emailRequired;
    }

    bool isEmail = RegexStrings.emailRegEx.hasMatch(value);

    bool isName = RegexStrings.isName.hasMatch(value);

    if (!isEmail && !isName) {
      return "Enter a valid name or email";
    }

    return null;
  }
}
