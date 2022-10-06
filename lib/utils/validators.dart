import 'package:flutter/widgets.dart' show FormFieldValidator;

class Validators {
  static FormFieldValidator<String> required(String errorMessage) {
    return (value) {
      if (value!.isEmpty) {
        return errorMessage;
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String> min(double min, String errorMessage) {
    return (value) {
      if (value!.trim().isEmpty) {
        return null;
      } else {
        final dValue = _toDouble(value);
        if (dValue < min) {
          return errorMessage;
        } else {
          return null;
        }
      }
    };
  }

  static FormFieldValidator<String> max(double max, String errorMessage) {
    return (value) {
      if (value!.trim().isEmpty) {
        return null;
      } else {
        final dValue = _toDouble(value);
        if (dValue > max) {
          return errorMessage;
        } else {
          return null;
        }
      }
    };
  }

  static FormFieldValidator<String> email(String errorMessage) {
    return (value) {
      if (value!.isEmpty) {
        return null;
      } else {
        final emailRegex = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
        if (emailRegex.hasMatch(value)) {
          return null;
        } else {
          return errorMessage;
        }
      }
    };
  }

  static FormFieldValidator<String> caseError(
    String errorMessage,
    String case1err,
    String case2err,
    String case3err,
    String case4err,
    String case6err,
    String case7err,
    String case9err,
  ) {
    return (value) {
      if (value!.isEmpty) {
        return errorMessage;
      } else {
        final upRegex = RegExp(r"(?=.[A-Z]+)");
        final speRegex = RegExp(r"(?=.[ -/:-@[-`{-~]+)");
        const minLength = 8;

        if (value.length < minLength) {
          if (!upRegex.hasMatch(value)) {
            if (!speRegex.hasMatch(value)) {
              {
                print('น้อยกว่า ไม่เจอใหญ่ ไม่เจอประหลาด');
                print(value);
                return case1err;
              }
            }
            if (speRegex.hasMatch(value)) {
              {
                print("น้อยกว่า8 ไม่เจอตัวใหญ่ เจอตัวประหลาด");
                print(value);
                return case7err;
              }
            }
          }
          if (upRegex.hasMatch(value)) {
            if (!speRegex.hasMatch(value)) {
              {
                print('น้อยกว่า เจอใหญ่ ไม่เจอประหลาด');
                print(value);
                return case9err;
              }
            }
            if (speRegex.hasMatch(value)) {
              {
                print('น้อยกว่า เจอใหญ่ เจอประหลาด');
                print(value);
                return case4err;
              }
            }
          }
        }
        if (value.length >= minLength) {
          if (!upRegex.hasMatch(value)) {
            if (!speRegex.hasMatch(value)) {
              {
                print('มากกว่า ไม่เจอใหญ่ ไม่เจอประหลาด');
                print(value);
                return case6err;
              }
            }
            // if(speRegex.hasMatch(value)){
            //   {
            //     print("มากกว่า8 ไม่เจอตัวใหญ่ เจอตัวประหลาด");
            //     print(value);
            //     return case2err;
            //   }
            // }
          }
          if (upRegex.hasMatch(value)) {
            if (!speRegex.hasMatch(value)) {
              {
                print('มากกว่า เจอใหญ่ ไม่เจอประหลาด');
                print(value);
                return case3err;
              }
            }
            if (speRegex.hasMatch(value)) {
              {
                print('มากกว่า เจอใหญ่ เจอประหลาด');
                print(value);
                return null;
              }
            }
          }
        }
      }
      return null;
    };
  }

  static FormFieldValidator<String> minLength(
      int minLength, String errorMessage) {
    return (value) {
      if (value!.isEmpty) return null;

      if (value.length < minLength) {
        return errorMessage;
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String> maxLength(
      int maxLength, String errorMessage) {
    return (value) {
      if (value!.isEmpty) return null;

      if (value.length > maxLength) {
        return errorMessage;
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String> patternString(
      String pattern, String errorMessage) {
    return patternRegExp(RegExp(pattern), errorMessage);
  }

  static FormFieldValidator<String> patternRegExp(
      RegExp pattern, String errorMessage) {
    return (value) {
      if (value!.isEmpty) return null;

      if (pattern.hasMatch(value)) {
        return null;
      } else {
        return errorMessage;
      }
    };
  }

  static FormFieldValidator<String> compose(
      List<FormFieldValidator<String>> validators) {
    return (value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }

  // -------------------- private functions ---------------------- //

  static double _toDouble(String value) {
    value = value.replaceAll(' ', '').replaceAll(',', '');
    return double.parse(value);
  }
}
