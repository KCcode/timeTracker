import 'StringValidator.dart';

class NonEmptyStringValidator implements StringValidator{
  @override
  bool isValid(String value){
    return value.isNotEmpty;
  }
}