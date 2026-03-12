import 'package:flutter/material.dart';

import 'package:cidr/model.dart';

class ThemeColor {
  final int? themeNumber;
  final BuildContext context;

  ThemeColor({this.themeNumber, required this.context});

  Brightness get _effectiveBrightness {
    switch (themeNumber) {
      case 1:
        return Brightness.light;
      case 2:
        return Brightness.dark;
      default:
        return Theme.of(context).brightness;
    }
  }

  static const List<Color> _colorSchemeRainbowLight = [
    Color(0xFFc19fd8),
    Color(0xFFaa9fd8),
    Color(0xFFa0abd8),
    Color(0xFF9fbcd9),
    Color(0xFF9ecfdb),
    Color(0xFF9edcce),
    Color(0xFF9edcad),
    Color(0xFFb5dca4),
    Color(0xFFd8dca4),
    Color(0xFFdbc3a4),
    Color(0xFFdbafa2),
    Color(0xFFdba0b0),
    Color(0xFFdba0cc),
  ];
  static const List<Color> _colorSchemeRainbowDark = [
    Color(0xff352442),
    Color(0xff30294c),
    Color(0xff2b314e),
    Color(0xff263647),
    Color(0xff233c43),
    Color(0xff22423a),
    Color(0xff25472e),
    Color(0xFF2F4326),
    Color(0xFF474A2A),
    Color(0xff493a29),
    Color(0xff432c26),
    Color(0xff43242d),
    Color(0xff43243b),
  ];

  static const List<Color> _colorSchemeWhiteLight = [
    Color(0xfffafafa),
    Color(0xffffffff),
  ];
  static const List<Color> _colorSchemeWhiteDark = [
    Color(0xff3a3a3a),
    Color(0xff404040),
  ];
  static const List<Color> _colorSchemeBlackLight = [
    Color(0xffbbbbbb),
    Color(0xffc4c4c4),
  ];
  static const List<Color> _colorSchemeBlackDark = [
    Color(0xff000000),
    Color(0xff161616),
  ];
  static const List<Color> _colorSchemeRedLight = [
    Color(0xffffe2e2),
    Color(0xffffeeee),
  ];
  static const List<Color> _colorSchemeRedDark = [
    Color(0xff220000),
    Color(0xff2e0000),
  ];
  static const List<Color> _colorSchemeOrangeLight = [
    Color(0xffffe2d2),
    Color(0xffffeedd),
  ];
  static const List<Color> _colorSchemeOrangeDark = [
    Color(0xff221100),
    Color(0xff2e1e00),
  ];
  static const List<Color> _colorSchemeYellowLight = [
    Color(0xffffffcc),
    Color(0xffffffdd),
  ];
  static const List<Color> _colorSchemeYellowDark = [
    Color(0xff222200),
    Color(0xff2e2e00),
  ];
  static const List<Color> _colorSchemeGreenLight = [
    Color(0xffd2ffd2),
    Color(0xffddffdd),
  ];
  static const List<Color> _colorSchemeGreenDark = [
    Color(0xff002200),
    Color(0xff002e00),
  ];
  static const List<Color> _colorSchemeBlueLight = [
    Color(0xffd6d6ff),
    Color(0xffddddff),
  ];
  static const List<Color> _colorSchemeBlueDark = [
    Color(0xff000022),
    Color(0xff000033),
  ];
  static const List<Color> _colorSchemePurpleLight = [
    Color(0xffffd2ff),
    Color(0xffffddff),
  ];
  static const List<Color> _colorSchemePurpleDark = [
    Color(0xff220022),
    Color(0xff2e002e),
  ];

  bool get _isLight => _effectiveBrightness == Brightness.light;

  //main page
  Color get mainBack1 {
    if (Model.colorScheme == 0) {
      return _isLight ? _colorSchemeRainbowLight[0] : _colorSchemeRainbowDark[0];
    } else if (Model.colorScheme == 1) {
      return _isLight ? _colorSchemeWhiteLight[0] : _colorSchemeWhiteDark[0];
    } else if (Model.colorScheme == 2) {
      return _isLight ? _colorSchemeBlackLight[0] : _colorSchemeBlackDark[0];
    } else if (Model.colorScheme == 3) {
      return _isLight ? _colorSchemeRedLight[0] : _colorSchemeRedDark[0];
    } else if (Model.colorScheme == 4) {
      return _isLight ? _colorSchemeOrangeLight[0] : _colorSchemeOrangeDark[0];
    } else if (Model.colorScheme == 5) {
      return _isLight ? _colorSchemeYellowLight[0] : _colorSchemeYellowDark[0];
    } else if (Model.colorScheme == 6) {
      return _isLight ? _colorSchemeGreenLight[0] : _colorSchemeGreenDark[0];
    } else if (Model.colorScheme == 7) {
      return _isLight ? _colorSchemeBlueLight[0] : _colorSchemeBlueDark[0];
    } else if (Model.colorScheme == 8) {
      return _isLight ? _colorSchemePurpleLight[0] : _colorSchemePurpleDark[0];
    }
    return _isLight ? _colorSchemeRainbowLight[0] : _colorSchemeRainbowDark[0];
  }
  Color get mainBack2 {
    if (Model.colorScheme == 0) {
      return _isLight ? _colorSchemeRainbowLight[1] : _colorSchemeRainbowDark[1];
    } else if (Model.colorScheme == 1) {
      return _isLight ? _colorSchemeWhiteLight[1] : _colorSchemeWhiteDark[1];
    } else if (Model.colorScheme == 2) {
      return _isLight ? _colorSchemeBlackLight[1] : _colorSchemeBlackDark[1];
    } else if (Model.colorScheme == 3) {
      return _isLight ? _colorSchemeRedLight[1] : _colorSchemeRedDark[1];
    } else if (Model.colorScheme == 4) {
      return _isLight ? _colorSchemeOrangeLight[1] : _colorSchemeOrangeDark[1];
    } else if (Model.colorScheme == 5) {
      return _isLight ? _colorSchemeYellowLight[1] : _colorSchemeYellowDark[1];
    } else if (Model.colorScheme == 6) {
      return _isLight ? _colorSchemeGreenLight[1] : _colorSchemeGreenDark[1];
    } else if (Model.colorScheme == 7) {
      return _isLight ? _colorSchemeBlueLight[1] : _colorSchemeBlueDark[1];
    } else if (Model.colorScheme == 8) {
      return _isLight ? _colorSchemePurpleLight[1] : _colorSchemePurpleDark[1];
    }
    return _isLight ? _colorSchemeRainbowLight[1] : _colorSchemeRainbowDark[1];
  }
  Color get mainBack3 {
    if (Model.colorScheme == 0) {
      return _isLight ? _colorSchemeRainbowLight[2] : _colorSchemeRainbowDark[2];
    } else if (Model.colorScheme == 1) {
      return _isLight ? _colorSchemeWhiteLight[0] : _colorSchemeWhiteDark[0];
    } else if (Model.colorScheme == 2) {
      return _isLight ? _colorSchemeBlackLight[0] : _colorSchemeBlackDark[0];
    } else if (Model.colorScheme == 3) {
      return _isLight ? _colorSchemeRedLight[0] : _colorSchemeRedDark[0];
    } else if (Model.colorScheme == 4) {
      return _isLight ? _colorSchemeOrangeLight[0] : _colorSchemeOrangeDark[0];
    } else if (Model.colorScheme == 5) {
      return _isLight ? _colorSchemeYellowLight[0] : _colorSchemeYellowDark[0];
    } else if (Model.colorScheme == 6) {
      return _isLight ? _colorSchemeGreenLight[0] : _colorSchemeGreenDark[0];
    } else if (Model.colorScheme == 7) {
      return _isLight ? _colorSchemeBlueLight[0] : _colorSchemeBlueDark[0];
    } else if (Model.colorScheme == 8) {
      return _isLight ? _colorSchemePurpleLight[0] : _colorSchemePurpleDark[0];
    }
    return _isLight ? _colorSchemeRainbowLight[2] : _colorSchemeRainbowDark[2];
  }
  Color get mainBack4 {
    if (Model.colorScheme == 0) {
      return _isLight ? _colorSchemeRainbowLight[3] : _colorSchemeRainbowDark[3];
    } else if (Model.colorScheme == 1) {
      return _isLight ? _colorSchemeWhiteLight[1] : _colorSchemeWhiteDark[1];
    } else if (Model.colorScheme == 2) {
      return _isLight ? _colorSchemeBlackLight[1] : _colorSchemeBlackDark[1];
    } else if (Model.colorScheme == 3) {
      return _isLight ? _colorSchemeRedLight[1] : _colorSchemeRedDark[1];
    } else if (Model.colorScheme == 4) {
      return _isLight ? _colorSchemeOrangeLight[1] : _colorSchemeOrangeDark[1];
    } else if (Model.colorScheme == 5) {
      return _isLight ? _colorSchemeYellowLight[1] : _colorSchemeYellowDark[1];
    } else if (Model.colorScheme == 6) {
      return _isLight ? _colorSchemeGreenLight[1] : _colorSchemeGreenDark[1];
    } else if (Model.colorScheme == 7) {
      return _isLight ? _colorSchemeBlueLight[1] : _colorSchemeBlueDark[1];
    } else if (Model.colorScheme == 8) {
      return _isLight ? _colorSchemePurpleLight[1] : _colorSchemePurpleDark[1];
    }
    return _isLight ? _colorSchemeRainbowLight[3] : _colorSchemeRainbowDark[3];
  }
  Color get mainBack5 {
    if (Model.colorScheme == 0) {
      return _isLight ? _colorSchemeRainbowLight[4] : _colorSchemeRainbowDark[4];
    } else if (Model.colorScheme == 1) {
      return _isLight ? _colorSchemeWhiteLight[0] : _colorSchemeWhiteDark[0];
    } else if (Model.colorScheme == 2) {
      return _isLight ? _colorSchemeBlackLight[0] : _colorSchemeBlackDark[0];
    } else if (Model.colorScheme == 3) {
      return _isLight ? _colorSchemeRedLight[0] : _colorSchemeRedDark[0];
    } else if (Model.colorScheme == 4) {
      return _isLight ? _colorSchemeOrangeLight[0] : _colorSchemeOrangeDark[0];
    } else if (Model.colorScheme == 5) {
      return _isLight ? _colorSchemeYellowLight[0] : _colorSchemeYellowDark[0];
    } else if (Model.colorScheme == 6) {
      return _isLight ? _colorSchemeGreenLight[0] : _colorSchemeGreenDark[0];
    } else if (Model.colorScheme == 7) {
      return _isLight ? _colorSchemeBlueLight[0] : _colorSchemeBlueDark[0];
    } else if (Model.colorScheme == 8) {
      return _isLight ? _colorSchemePurpleLight[0] : _colorSchemePurpleDark[0];
    }
    return _isLight ? _colorSchemeRainbowLight[4] : _colorSchemeRainbowDark[4];
  }
  Color get mainBack6 {
    if (Model.colorScheme == 0) {
      return _isLight ? _colorSchemeRainbowLight[5] : _colorSchemeRainbowDark[5];
    } else if (Model.colorScheme == 1) {
      return _isLight ? _colorSchemeWhiteLight[1] : _colorSchemeWhiteDark[1];
    } else if (Model.colorScheme == 2) {
      return _isLight ? _colorSchemeBlackLight[1] : _colorSchemeBlackDark[1];
    } else if (Model.colorScheme == 3) {
      return _isLight ? _colorSchemeRedLight[1] : _colorSchemeRedDark[1];
    } else if (Model.colorScheme == 4) {
      return _isLight ? _colorSchemeOrangeLight[1] : _colorSchemeOrangeDark[1];
    } else if (Model.colorScheme == 5) {
      return _isLight ? _colorSchemeYellowLight[1] : _colorSchemeYellowDark[1];
    } else if (Model.colorScheme == 6) {
      return _isLight ? _colorSchemeGreenLight[1] : _colorSchemeGreenDark[1];
    } else if (Model.colorScheme == 7) {
      return _isLight ? _colorSchemeBlueLight[1] : _colorSchemeBlueDark[1];
    } else if (Model.colorScheme == 8) {
      return _isLight ? _colorSchemePurpleLight[1] : _colorSchemePurpleDark[1];
    }
    return _isLight ? _colorSchemeRainbowLight[5] : _colorSchemeRainbowDark[5];
  }
  Color get mainBack7 {
    if (Model.colorScheme == 0) {
      return _isLight ? _colorSchemeRainbowLight[6] : _colorSchemeRainbowDark[6];
    } else if (Model.colorScheme == 1) {
      return _isLight ? _colorSchemeWhiteLight[0] : _colorSchemeWhiteDark[0];
    } else if (Model.colorScheme == 2) {
      return _isLight ? _colorSchemeBlackLight[0] : _colorSchemeBlackDark[0];
    } else if (Model.colorScheme == 3) {
      return _isLight ? _colorSchemeRedLight[0] : _colorSchemeRedDark[0];
    } else if (Model.colorScheme == 4) {
      return _isLight ? _colorSchemeOrangeLight[0] : _colorSchemeOrangeDark[0];
    } else if (Model.colorScheme == 5) {
      return _isLight ? _colorSchemeYellowLight[0] : _colorSchemeYellowDark[0];
    } else if (Model.colorScheme == 6) {
      return _isLight ? _colorSchemeGreenLight[0] : _colorSchemeGreenDark[0];
    } else if (Model.colorScheme == 7) {
      return _isLight ? _colorSchemeBlueLight[0] : _colorSchemeBlueDark[0];
    } else if (Model.colorScheme == 8) {
      return _isLight ? _colorSchemePurpleLight[0] : _colorSchemePurpleDark[0];
    }
    return _isLight ? _colorSchemeRainbowLight[6] : _colorSchemeRainbowDark[6];
  }
  Color get mainBack8 {
    if (Model.colorScheme == 0) {
      return _isLight ? _colorSchemeRainbowLight[7] : _colorSchemeRainbowDark[7];
    } else if (Model.colorScheme == 1) {
      return _isLight ? _colorSchemeWhiteLight[1] : _colorSchemeWhiteDark[1];
    } else if (Model.colorScheme == 2) {
      return _isLight ? _colorSchemeBlackLight[1] : _colorSchemeBlackDark[1];
    } else if (Model.colorScheme == 3) {
      return _isLight ? _colorSchemeRedLight[1] : _colorSchemeRedDark[1];
    } else if (Model.colorScheme == 4) {
      return _isLight ? _colorSchemeOrangeLight[1] : _colorSchemeOrangeDark[1];
    } else if (Model.colorScheme == 5) {
      return _isLight ? _colorSchemeYellowLight[1] : _colorSchemeYellowDark[1];
    } else if (Model.colorScheme == 6) {
      return _isLight ? _colorSchemeGreenLight[1] : _colorSchemeGreenDark[1];
    } else if (Model.colorScheme == 7) {
      return _isLight ? _colorSchemeBlueLight[1] : _colorSchemeBlueDark[1];
    } else if (Model.colorScheme == 8) {
      return _isLight ? _colorSchemePurpleLight[1] : _colorSchemePurpleDark[1];
    }
    return _isLight ? _colorSchemeRainbowLight[7] : _colorSchemeRainbowDark[7];
  }
  Color get mainBack9 {
    if (Model.colorScheme == 0) {
      return _isLight ? _colorSchemeRainbowLight[8] : _colorSchemeRainbowDark[8];
    } else if (Model.colorScheme == 1) {
      return _isLight ? _colorSchemeWhiteLight[0] : _colorSchemeWhiteDark[0];
    } else if (Model.colorScheme == 2) {
      return _isLight ? _colorSchemeBlackLight[0] : _colorSchemeBlackDark[0];
    } else if (Model.colorScheme == 3) {
      return _isLight ? _colorSchemeRedLight[0] : _colorSchemeRedDark[0];
    } else if (Model.colorScheme == 4) {
      return _isLight ? _colorSchemeOrangeLight[0] : _colorSchemeOrangeDark[0];
    } else if (Model.colorScheme == 5) {
      return _isLight ? _colorSchemeYellowLight[0] : _colorSchemeYellowDark[0];
    } else if (Model.colorScheme == 6) {
      return _isLight ? _colorSchemeGreenLight[0] : _colorSchemeGreenDark[0];
    } else if (Model.colorScheme == 7) {
      return _isLight ? _colorSchemeBlueLight[0] : _colorSchemeBlueDark[0];
    } else if (Model.colorScheme == 8) {
      return _isLight ? _colorSchemePurpleLight[0] : _colorSchemePurpleDark[0];
    }
    return _isLight ? _colorSchemeRainbowLight[8] : _colorSchemeRainbowDark[8];
  }
  Color get mainBack10{
    if (Model.colorScheme == 0) {
      return  _isLight ? _colorSchemeRainbowLight[9] : _colorSchemeRainbowDark[9];
    } else if (Model.colorScheme == 1) {
      return _isLight ? _colorSchemeWhiteLight[1] : _colorSchemeWhiteDark[1];
    } else if (Model.colorScheme == 2) {
      return _isLight ? _colorSchemeBlackLight[1] : _colorSchemeBlackDark[1];
    } else if (Model.colorScheme == 3) {
      return _isLight ? _colorSchemeRedLight[1] : _colorSchemeRedDark[1];
    } else if (Model.colorScheme == 4) {
      return _isLight ? _colorSchemeOrangeLight[1] : _colorSchemeOrangeDark[1];
    } else if (Model.colorScheme == 5) {
      return _isLight ? _colorSchemeYellowLight[1] : _colorSchemeYellowDark[1];
    } else if (Model.colorScheme == 6) {
      return _isLight ? _colorSchemeGreenLight[1] : _colorSchemeGreenDark[1];
    } else if (Model.colorScheme == 7) {
      return _isLight ? _colorSchemeBlueLight[1] : _colorSchemeBlueDark[1];
    } else if (Model.colorScheme == 8) {
      return _isLight ? _colorSchemePurpleLight[1] : _colorSchemePurpleDark[1];
    }
    return  _isLight ? _colorSchemeRainbowLight[9] : _colorSchemeRainbowDark[9];
  }
  Color get mainBack11{
    if (Model.colorScheme == 0) {
      return  _isLight ? _colorSchemeRainbowLight[10] : _colorSchemeRainbowDark[10];
    } else if (Model.colorScheme == 1) {
      return _isLight ? _colorSchemeWhiteLight[0] : _colorSchemeWhiteDark[0];
    } else if (Model.colorScheme == 2) {
      return _isLight ? _colorSchemeBlackLight[0] : _colorSchemeBlackDark[0];
    } else if (Model.colorScheme == 3) {
      return _isLight ? _colorSchemeRedLight[0] : _colorSchemeRedDark[0];
    } else if (Model.colorScheme == 4) {
      return _isLight ? _colorSchemeOrangeLight[0] : _colorSchemeOrangeDark[0];
    } else if (Model.colorScheme == 5) {
      return _isLight ? _colorSchemeYellowLight[0] : _colorSchemeYellowDark[0];
    } else if (Model.colorScheme == 6) {
      return _isLight ? _colorSchemeGreenLight[0] : _colorSchemeGreenDark[0];
    } else if (Model.colorScheme == 7) {
      return _isLight ? _colorSchemeBlueLight[0] : _colorSchemeBlueDark[0];
    } else if (Model.colorScheme == 8) {
      return _isLight ? _colorSchemePurpleLight[0] : _colorSchemePurpleDark[0];
    }
    return  _isLight ? _colorSchemeRainbowLight[10] : _colorSchemeRainbowDark[10];
  }
  Color get mainBack12{
    if (Model.colorScheme == 0) {
      return  _isLight ? _colorSchemeRainbowLight[11] : _colorSchemeRainbowDark[11];
    } else if (Model.colorScheme == 1) {
      return _isLight ? _colorSchemeWhiteLight[1] : _colorSchemeWhiteDark[1];
    } else if (Model.colorScheme == 2) {
      return _isLight ? _colorSchemeBlackLight[1] : _colorSchemeBlackDark[1];
    } else if (Model.colorScheme == 3) {
      return _isLight ? _colorSchemeRedLight[1] : _colorSchemeRedDark[1];
    } else if (Model.colorScheme == 4) {
      return _isLight ? _colorSchemeOrangeLight[1] : _colorSchemeOrangeDark[1];
    } else if (Model.colorScheme == 5) {
      return _isLight ? _colorSchemeYellowLight[1] : _colorSchemeYellowDark[1];
    } else if (Model.colorScheme == 6) {
      return _isLight ? _colorSchemeGreenLight[1] : _colorSchemeGreenDark[1];
    } else if (Model.colorScheme == 7) {
      return _isLight ? _colorSchemeBlueLight[1] : _colorSchemeBlueDark[1];
    } else if (Model.colorScheme == 8) {
      return _isLight ? _colorSchemePurpleLight[1] : _colorSchemePurpleDark[1];
    }
    return  _isLight ? _colorSchemeRainbowLight[11] : _colorSchemeRainbowDark[11];
  }
  Color get mainBack13{
    if (Model.colorScheme == 0) {
      return  _isLight ? _colorSchemeRainbowLight[12] : _colorSchemeRainbowDark[12];
    } else if (Model.colorScheme == 1) {
      return _isLight ? _colorSchemeWhiteLight[0] : _colorSchemeWhiteDark[0];
    } else if (Model.colorScheme == 2) {
      return _isLight ? _colorSchemeBlackLight[0] : _colorSchemeBlackDark[0];
    } else if (Model.colorScheme == 3) {
      return _isLight ? _colorSchemeRedLight[0] : _colorSchemeRedDark[0];
    } else if (Model.colorScheme == 4) {
      return _isLight ? _colorSchemeOrangeLight[0] : _colorSchemeOrangeDark[0];
    } else if (Model.colorScheme == 5) {
      return _isLight ? _colorSchemeYellowLight[0] : _colorSchemeYellowDark[0];
    } else if (Model.colorScheme == 6) {
      return _isLight ? _colorSchemeGreenLight[0] : _colorSchemeGreenDark[0];
    } else if (Model.colorScheme == 7) {
      return _isLight ? _colorSchemeBlueLight[0] : _colorSchemeBlueDark[0];
    } else if (Model.colorScheme == 8) {
      return _isLight ? _colorSchemePurpleLight[0] : _colorSchemePurpleDark[0];
    }
    return  _isLight ? _colorSchemeRainbowLight[12] : _colorSchemeRainbowDark[12];
  }

  Color get mainHeaderForeColor => _isLight ? Color.fromRGBO(0, 0, 0, 0.5) : Color.fromRGBO(255, 255, 255, 0.5);
  Color get mainForeColor => _isLight ? Color.fromRGBO(0, 0, 0, 1.0) : Color.fromRGBO(255, 255, 255, 1.0);
  //setting page
  Color get backColor => _isLight ? Colors.grey[200]! : Colors.grey[900]!;
  Color get cardColor => _isLight ? Colors.white : Colors.grey[800]!;
  Color get appBarForegroundColor => _isLight ? Colors.grey[700]! : Colors.white70;
  Color get dropdownColor => cardColor;
  Color get borderColor => _isLight ? Colors.grey[300]! : Colors.grey[700]!;
  Color get inputFillColor => _isLight ? Colors.grey[50]! : Colors.grey[900]!;
}
