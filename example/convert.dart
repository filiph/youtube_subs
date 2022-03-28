import 'dart:convert';
import 'dart:io';

import 'package:youtube_subs/youtube_subs.dart';

void main(List<String> args) async {
  final string = await stdin.transform(Utf8Decoder()).join();
  final subs = YouTubeSubs.fromString(string);
  print(subs.render().join());
}
