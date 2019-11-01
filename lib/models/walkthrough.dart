import "package:flutter/material.dart";

class Walkthrough {
  Image icon;
  String title;

  Widget extraWidget;

  Walkthrough({this.icon, this.title, this.extraWidget}) {
    if (extraWidget == null) {
      extraWidget = new Container();
    }
  }
}