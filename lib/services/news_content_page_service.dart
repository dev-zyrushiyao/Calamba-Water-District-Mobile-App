class NewsContentPageService {
  //method string buffer -> for paragraphs or bulleted list
  String formatList({required List<String> items, bool bulletFormat = false}) {
    final buffer = StringBuffer();

    for (var item in items) {
      bulletFormat ? buffer.writeln("• $item") : buffer.writeln(item);
      buffer.writeln("");
    }
    return buffer.toString();
  }
}
