import 'package:flutter/material.dart';

class SearchBarClipArea extends CustomClipper<Path>{
  double percentage;
  double getRadius(double width)=> percentage * width;
  SearchBarClipArea(this.percentage);

  @override
  Rect getApproximateClipRect(Size size) {
    // TODO: implement getApproximateClipRect
    var radius = getRadius(size.width);
    return Rect.fromLTRB(size.width - radius, 0, radius, radius);
  }
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var p = Path();
    p.lineTo(size.width, 0);
    p.lineTo(size.width - getRadius(size.width),0);
    p.arcToPoint(Offset(size.width,getRadius(size.width)),radius: Radius.circular(getRadius(size.width)),clockwise: false);
    p.lineTo(size.width, 0);
    return p;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}