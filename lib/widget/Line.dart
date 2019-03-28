import 'package:flutter/widgets.dart';
import 'package:love_stars/common/style/AppColors.dart';

class H_Line extends StatelessWidget {
  final Color color;
  final double height;
  final EdgeInsets margin;

  H_Line({this.color, this.height = 0.3, this.margin});

  @override
  Widget build(BuildContext context) {
    EdgeInsets margin = this.margin;
    Color color = this.color;
    margin ??=
        EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0);
    color ??= new Color(AppColors.lineColor);
    return new Container(color: color, margin: margin, height: height);
  }
}

class V_Line extends StatelessWidget {
  final Color color;
  final double width;
  final EdgeInsets margin;

  V_Line({this.color, this.width = 1, this.margin});

  @override
  Widget build(BuildContext context) {
    EdgeInsets margin = this.margin;
    Color color = this.color;
    margin ??= EdgeInsets.all(0);
    color ??= new Color(AppColors.lineColor);
    return new Container(color: color, margin: margin, width: width);
  }
}
