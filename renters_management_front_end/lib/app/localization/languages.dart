import 'package:get/get.dart';
import './arabic_language.dart';
import './english_language.dart';

class Languages implements Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>{
    'ar':Arabic().dictionary,
    'en':Engilsh().dictionary
  };


}