import 'package:form_field_validator/form_field_validator.dart';

final nameValidator = RequiredValidator(errorText: 'Ingrese un nombre');

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'Ingrese la dirección de correo electrónico'),
  EmailValidator(errorText: 'La dirección de corre electrónico no es válida')
]);
var validarcont = passwordValidator;
final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Ingrese la contraseña'),
  MinLengthValidator(8,
      errorText: 'La contraseña debe contener mínimo 8 caracteres'),
]);
final password_confiValidator = MultiValidator([
  RequiredValidator(errorText: 'Ingrese la contraseña'),
  MinLengthValidator(8,
      errorText: 'La contraseña debe contener mínimo 8 caracteres'),
]);
