import 'package:form_field_validator/form_field_validator.dart';

final nameValidator = RequiredValidator(errorText: 'Ingrese un nombre');

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'Ingrese la dirección de correo electrónico'),
  EmailValidator(errorText: 'La dirección de corre electrónico no es válida')
]);
final passwordValidatoro = MultiValidator([
  RequiredValidator(errorText: 'Ingrese la contraseña'),
]);
final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Ingrese la contraseña'),
  PatternValidator(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
      errorText: 'Mínimo 1 mayúscula,1 número y 1 carácter especial'),
   MaxLengthValidator(16, errorText: 'La contraseña debe contener maximo 16 caracteres'),
  MinLengthValidator(8,
      errorText: 'La contraseña debe contener mínimo 8 caracteres'),
]);
final password_confiValidator = MultiValidator([
  RequiredValidator(errorText: 'Ingrese la contraseña'),
  PatternValidator(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
      errorText: 'Mínimo 1 mayúscula,1 número y 1 carácter especial'),
  MaxLengthValidator(16,
      errorText: 'La contraseña debe contener maximo 16 caracteres'),
  MinLengthValidator(8,
      errorText: 'La contraseña debe contener mínimo 8 caracteres'),
]);
