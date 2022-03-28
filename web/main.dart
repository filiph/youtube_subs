import 'dart:html';

import 'package:youtube_subs/youtube_subs.dart';

void main() {
  var button = querySelector('#submit')! as ButtonElement;
  button.onClick.listen(_handleSubmit);
}

void _handleSubmit(MouseEvent event) {
  var input = querySelector('#input')! as TextAreaElement;
  var output = querySelector('#output')! as TextAreaElement;

  var subs = YouTubeSubs.fromString(input.value ?? 'N/A');
  var result = subs.render().join();

  output.value = result;
}
