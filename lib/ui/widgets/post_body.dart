import 'package:flutter/material.dart';
import 'package:gym/models/video_adapter.dart';
import 'package:video_player/video_player.dart';
class PostBody extends StatelessWidget {
  final Widget body;
  PostBody({this.body});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: body
    );
  }
}
