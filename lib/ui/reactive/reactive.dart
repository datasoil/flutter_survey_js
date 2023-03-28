import 'package:reactive_forms/reactive_forms.dart';

class NumStringValueAccessor extends ControlValueAccessor<num, String> {
  @override
  String? modelToViewValue(num? modelValue) {
    return modelValue?.toString();
  }

  @override
  num? viewToModelValue(String? viewValue) {
    print(viewValue);
    return viewValue == null
        ? null
        : num.tryParse(viewValue.replaceAll(',', '.'));
  }
}

/// Validator that validates if control's value is a numeric value.
class NullableNumberValidator extends Validator<dynamic> {
  /// The regex expression of a numeric string value.
  static final RegExp numberRegex = RegExp(r'^-?[0-9]+([,.]?[0-9]+)?$');

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    return (control.value != null) &&
            !numberRegex.hasMatch(control.value.toString())
        ? <String, dynamic>{ValidationMessage.number: true}
        : null;
  }
}

/// Validator that requires the control's value to be greater than or equal
/// to a provided value.
class NullableMinValidator<T> extends Validator<dynamic> {
  final T min;

  /// Constructs the instance of the validator.
  ///
  /// The argument [min] must not be null.
  NullableMinValidator(this.min);

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = {
      ValidationMessage.min: <String, dynamic>{
        'min': min,
        'actual': control.value,
      },
    };
    return (control.value != null) &&
            (control.value as Comparable<dynamic>).compareTo(min) < 0
        ? error
        : null;
  }
}

/// validator that requires the control's value to be less than or equal to a
/// provided value.
class NullableMaxValidator<T> extends Validator<dynamic> {
  final T max;

  /// Constructs the instance of the validator.
  ///
  /// The argument [max] must not be null.
  NullableMaxValidator(this.max);

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = {
      ValidationMessage.max: <String, dynamic>{
        'max': max,
        'actual': control.value,
      },
    };

    return (control.value != null) &&
            (control.value as Comparable<dynamic>).compareTo(max) > 0
        ? error
        : null;
  }
}

class NullableValidators {
  static ValidatorFunction get number => NullableNumberValidator().validate;

  static ValidatorFunction min<T>(T min) =>
      NullableMinValidator<T>(min).validate;

  static ValidatorFunction max<T>(T max) =>
      NullableMaxValidator<T>(max).validate;
}
