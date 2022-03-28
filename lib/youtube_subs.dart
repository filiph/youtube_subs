import 'package:characters/characters.dart';

class YouTubeSubs {
  final List<_Sentence> sentences;

  YouTubeSubs(this.sentences);

  factory YouTubeSubs.fromString(String string) {
    var chars = string.characters;

    var sentences = <_Sentence>[];
    var sentenceStart = 0;
    for (int i = 0; i < chars.length; i++) {
      final char = chars.characterAt(i);
      if (_sentenceEndPunctuation.hasMatch(char.string)) {
        // Possible end of sentence.
        if (chars.length == i + 1 ||
            _whitespace.hasMatch(chars.characterAt(i + 1).string)) {
          var sentenceChars = chars.getRange(sentenceStart, i);
          var sentenceEndPunctuation = char;
          sentences.add(
              _Sentence.fromCharacters(sentenceChars, sentenceEndPunctuation));
          // The punctuation plus the whitespace.
          sentenceStart = i + 2;
        }
      }
    }

    return YouTubeSubs(sentences);
  }

  Iterable<String> render() sync* {
    for (final sentence in sentences) {
      yield* sentence.render();
      yield ' ';
    }
  }

  @override
  String toString() => 'YouTubeSubs(${sentences.length} sentences)';
}

class _Sentence {
  final List<_Word> words;

  _Sentence(this.words, this.endPunctuation);

  factory _Sentence.fromCharacters(
      Characters rawSentence, Characters endPunctuation) {
    final words = <_Word>[];

    var wordStart = 0;
    for (int i = 0; i < rawSentence.length; i++) {
      if (_whitespace.hasMatch(rawSentence.characterAt(i).string)) {
        var wordChars = rawSentence.getRange(wordStart, i);

        final isNotEmpty =
            wordChars.isNotEmpty && !_whitespace.hasMatch(wordChars.string);
        final isNotFillWord = !_fillWords.contains(wordChars.string);
        bool isNotRepeatingLastWord = true;
        if (words.isNotEmpty) {
          if (words.last.text == wordChars) {
            isNotRepeatingLastWord = false;
          }
        }
        if (isNotEmpty && isNotFillWord && isNotRepeatingLastWord) {
          words.add(_Word(wordChars));
        }
        // The punctuation plus the whitespace.
        wordStart = i + 1;
      }
    }
    var wordChars = rawSentence.getRange(wordStart);
    words.add(_Word(wordChars));

    return _Sentence(words, endPunctuation);
  }

  Characters endPunctuation;

  Iterable<String> render() sync* {
    yield* words.first.render(capitalized: true);

    for (final word in words.skip(1)) {
      yield ' ';
      yield* word.render();
    }

    yield endPunctuation.string;
  }
}

final _sentenceEndPunctuation = RegExp(r'[\!\?\.]+');

final _whitespace = RegExp(r'^\s+$');

class _Word {
  final Characters text;

  _Word(this.text)
      : assert(text.isNotEmpty),
        assert(text.characterAt(0).isNotEmpty);

  Iterable<String> render({bool capitalized = false}) sync* {
    for (var exception in _specialCapitalization) {
      if (exception.toLowerCase() == text.toLowerCase().string) {
        yield exception;
        return;
      }
    }

    // Special cases.
    final autoAllCaps = _alwaysAllCaps.contains(text.string);
    if (autoAllCaps) {
      yield text.toUpperCase().string;
      return;
    }

    final autoCapitalized = _alwaysCapitalized.contains(text.string);
    if (capitalized || autoCapitalized) {
      yield text.characterAt(0).toUpperCase().string;
    } else {
      yield text.characterAt(0).string;
    }

    yield text.getRange(1).string;
  }
}

const _alwaysCapitalized = [
  'i',
  "i'll",
  "i'm",
  "i'd",
  'mac',
  'apple',
  'google',
  'flutter',
  'android',
  'filip',
  'prague',
  'czech',
  'linux',
  'windows',
  'speedometer',
  'udemy',
];

const _alwaysAllCaps = [
  'ide',
  'cpu',
  'ram',
  'usa',
];

const _specialCapitalization = [
  'MacBook',
  'JavaScript',
  'Xcode',
  'YouTube',
  'GitHub',
];

const _fillWords = [
  'um',
  'uh',
];
