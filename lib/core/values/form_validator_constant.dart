import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class FormValidatorConstant {
  static MultiValidator passwordValidatorForSignUp = MultiValidator([
    RequiredValidator(errorText: 'password is required'.tr),
    MinLengthValidator(6,
        errorText: 'password must be at least 6 digits long'.tr),
  ]);

  static MultiValidator passwordValidatorForSignIn = MultiValidator([
    RequiredValidator(errorText: 'password is required'.tr),
  ]);

  static MultiValidator emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'.tr),
    EmailValidator(errorText: 'enter a valid email address'.tr)
  ]);

  static MultiValidator commonValidator = MultiValidator([
    RequiredValidator(errorText: 'fill the required field'.tr),
  ]);
  static MultiValidator newPasswordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'.tr),
    MinLengthValidator(6,
        errorText: 'password must be at least 6 digits long'.tr),
  ]);
  static MultiValidator otpValidator = MultiValidator([
    RequiredValidator(errorText: 'fill the fields.'.tr),
    MinLengthValidator(4, errorText: 'fill all the fields.'.tr),
  ]);
  static MultiValidator mobileNumberValidator = MultiValidator([
    RequiredValidator(errorText: 'fill the fields.'.tr),
    MaxLengthValidator(11, errorText: 'fill all the fields.'.tr),
  ]);

  // static MultiValidator confirmPassword = MultiValidator([
  //   RequiredValidator(errorText: 'fill the fields.'.tr),
  //   MatchValidator(11, errorText: 'fill all the fields.'.tr),
  // ]);
}
