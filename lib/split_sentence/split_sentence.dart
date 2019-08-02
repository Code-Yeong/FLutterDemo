class WordSegEntry {
  String word;
  bool isEnglish;
  int startIndex;
  int endIndex;

//  WordSegEntry({
//    @required this.word,
//    this.isEnglish,
//    this.startIndex,
//    this.endIndex,
//  });

//  WordSegEntry() {
//    this.word = "";
//    this.isEnglish = false;
//    this.startIndex = 0;
//    this.endIndex = 0;
//  }

  @override
  String toString() {
    return "[word:$word isEnglish:$isEnglish startIndex:$startIndex endIndex:$endIndex]";
  }
}

class WordSeg {
  final String punctuation = "、，：；。！？\n"
      "｛｝（）〔〕＜＞〈〉《》［］「」『』〖〗【】\n"
      "＠＃％＊＆＋＝±×÷～－\u2014\u2015＿—─━￣\u2025…┈┄┅┉┆┇┊┋｜\ufe31│┃∥＼／\u2215\n"
      "‘’“”＂＇\u2035′\u301d″\u02ca\u02cb\n"
      "＄￡￥‰§№°℃\u2109\u2105\n"
      "＾ˇ¨｀°¤〃\n"
      "♂♀ ￠¤※\u2573\n"
      "\u221f\u2252\u2266\u2267\u22bf∧∨∑∏∪∩∈∷√⊥∥∠⌒⊙∫∮≡≌≈∽∝≠≮≯≤≥∞∵∴\n"
      "☆★○●◎◇◆□■△▲\u25bd\u25bc\u2609\n"
      "〓\u25e2\u25e3\u25e4\u25e5\u2594\u2581\u2582\u2583\u2585\u2587\u2588\u2589\u2593\u258a\u258b\u258c\u258d\u258e\u258f\u2595\n"
      "→←↑↓\u2196\u2197\u2198\u2199\n"
      "\u256d\u256e\u2570\u256f\n"
      "\ufe35\ufe36\ufe39\ufe3a\ufe3f\ufe40\ufe3d\ufe3e\ufe41\ufe42\ufe43\ufe44\ufe3b\ufe3c\ufe37\ufe38\n"
      "\u2550\u2551\u2552\u2553\u2554\u2555\u2556\u2557\u2559\u255a\u255b\u255c\u255d\u255e\u255f\u2560\u2561\u2562\u2563\u2564\u2565\u2566\u2567\u2568\u2569\u256a\u256b\u256c\u3012\n"
      "┌┍┎┏┐┑┒┓└┕┖┗┘┙┚┛├┝┞┟┠┡┢┣┤┥┦┧┨┩┪┫┬┭┮┯┰┱┲┳┴┵┶┷┸┹┺┻┼┽┾┿╀╁╂╃╄╅╆╇╈╉╊╋"
      "\n";

  String content;
  final List<WordSegEntry> segs = new List<WordSegEntry>();

  bool isPunctuation(int c) {
    return punctuation.contains(c.toString());
  }

  bool isDigit(int c) {
    return c >= 0x30 && c <= 0x39;
  }

  bool isLetter(int c) {
    return (c >= 0x41 && c <= 0x5A) || (c >= 0x61 && c <= 0x7A) || c == 0x27; // [ a-zA-Z' ]
  }

  WordSeg() {
    this.content = "";
  }

  void parseContent(String cont) {
    if (cont == null || cont.length == 0) {
      return;
    }

    this.content = cont;
    int lastCIsEnCn = 0; // 1-en,2-cn
    int last = 0;

    if (segs.length > 0) {
      segs.clear();
    }

    String str = "'";
    print('${str.codeUnitAt(0)}-----${isPunctuation(str.codeUnitAt(0))}');
    
    for (int i = 0; i < content.length; i++) {
      int c = content.codeUnitAt(i);

      if(c == 39){
        print(c);
        print(isPunctuation(c));
        print(isLetter(c));
        print(isDigit(c));
      }
      if (c <= 32) {
//        print('cccc:$c  ${content.substring(i, i+2)}   ${content.substring(last, i)}');
        // invisible chars
        if (lastCIsEnCn == 1) {
          // en ,break the words
          if (i > last) {
            WordSegEntry seg = new WordSegEntry();
            seg.word = content.substring(last, i);
            seg.isEnglish = true;
            seg.startIndex = last;
            seg.endIndex = i;
            segs.add(seg);
            last = i + 1;
          }
        }
      } else if (isPunctuation(c)) {
        print('c:$c');
        if (i > last) {
          if (lastCIsEnCn != 0) {
            WordSegEntry seg = new WordSegEntry();
            seg.word = content.substring(last, i);
            seg.isEnglish = lastCIsEnCn == 1;
            seg.startIndex = last;
            seg.endIndex = i;
            segs.add(seg);
          }
        }
        last = i + 1;
        lastCIsEnCn = 0;
      } else if ((isLetter(c) || isDigit(c)) && c < 127) {
//        print('c:$c   ${content.substring(last, i)}');
        // en word
        if (lastCIsEnCn == 2) {
          if (i > last) {
            WordSegEntry seg = new WordSegEntry();
            seg.word = content.substring(last, i);
            seg.isEnglish = false;
            seg.startIndex = last;
            seg.endIndex = i;
            segs.add(seg);
            last = i;
          }
        }
        lastCIsEnCn = 1;
      } else {
        // cn word
        if (lastCIsEnCn == 1) {
          if (i > last) {
            WordSegEntry seg = new WordSegEntry();
            seg.word = content.substring(last, i);
            seg.isEnglish = true;
            seg.startIndex = last;
            seg.endIndex = i;
            segs.add(seg);
            last = i;
          }
        }
        lastCIsEnCn = 2;
      }
    }

    if (last < content.length && lastCIsEnCn != 0) {
      WordSegEntry seg = new WordSegEntry();
      seg.word = content.substring(last, content.length);
      seg.isEnglish = lastCIsEnCn == 1;
      seg.startIndex = last;
      seg.endIndex = content.length;
      segs.add(seg);
    }

    for (int i = 0; i < segs.length; ++i) {
      WordSegEntry seg = segs[i];
      if (!seg.isEnglish) {
        seg.word = seg.word.replaceAll("\\s+", "");
      }
    }
  }
}

/// for examples:
/// WordSeg seg = new WordSeg();
///   seg.parseContent("There are moments in life when you miss someone so much that you just want to pick them from your dreams and hug them for real! Dream what you want to dream;go where you want to go;be what you want to be,because you have only one life and one chance to do all the things you want to do.");
/// List<WordSegEntry> list = seg.segs;
