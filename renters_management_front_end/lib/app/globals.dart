import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
class AppData{
}

class AppFonts{
  static  late ByteData ciroRegular;
  static  late ByteData ciroBold;
  static  late ByteData notoNaskhArabicRegular;
  static  late ByteData notoNaskhArabicBold;
  static  late ByteData arial;

  static Future<void> loadFonts() async {
    try{
      ciroRegular = await rootBundle.load('assets/fonts/Cairo-Regular.ttf');
      notoNaskhArabicRegular = await rootBundle.load('assets/fonts/NotoNaskhArabic-Regular.ttf');
      ciroBold = await rootBundle.load('assets/fonts/Cairo-Bold.ttf');
      notoNaskhArabicBold = await rootBundle.load('assets/fonts/NotoNaskhArabic-Bold.ttf');
      arial = await rootBundle.load('assets/fonts/ARIAL.TTF');


    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

class Utils {
  static double fontSizeScale(double fontSize) {
    // double screenRatio = Get.width / Get.height;
    // double designRatio = 411 / 891;
    // double ratio = (screenRatio>designRatio)?designRatio/screenRatio:screenRatio / designRatio;
    double ratio = Get.width/411;
    (ratio>1.2)?ratio=1.2:(ratio<0.8)?ratio=0.8:null;
    return fontSize * ratio;
  }
}

class AppColors {
  static ButtonColors buttonColors = ButtonColors(color:Color(int.parse("FF0D3976",radix: 16)));

  static Color mainTextColor = Colors.white;
  static Color inverseMainTextColor = Color(int.parse("DF0D3976",radix: 16));

  static Color secTextColor = Color(int.parse("FF0D3976",radix: 16));
  static Color inverseSecTextColor = Color(int.parse("5F0D3976",radix: 16));

  static Color linkTextColor = Colors.blueAccent;
  static Color coverColor =  const Color.fromRGBO(0, 191, 255, 0.25);

  static Color backColor = Color(int.parse("FFFFFFFF",radix: 16));
  //static Color tabBackColor = const Color.fromRGBO(235, 241, 253,1);
  static Color appBarColor = Color(int.parse("FF0D3976",radix: 16));

  static Color mainIconColor = Color(int.parse("FFFFFFFF",radix: 16));
  static Color inverseIconColor = Color(int.parse("FF0D3976",radix: 16));

  static Color mainCardColor = Color(int.parse("FFFFFFFF",radix: 16));
  static Color inverseCardColor = Color(int.parse("FF0D3976",radix: 16));


}

// structure for Buttons Coloring
class ButtonColors {
  ButtonColors({
    this.color = Colors.blueAccent,
    this.pressedColor = Colors.blueGrey,
    this.disableColor = Colors.grey,
  });

  Color color;
  Color pressedColor;
  Color disableColor;
}