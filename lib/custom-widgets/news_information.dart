class NewsInformation {
  final String? dateNum;
  final String? dateWord;
  final String? title;
  final String? status;
  final List<String> paragraph1;
  final String? imageDirectory;
  final Map<String?, String?>? headLine1;
  final List<String>? bulletList1;
  final Map<String?, String?>? headLine2;
  final List<String>? bulletList2;
  final Map<String?, String?>? headLine3;
  final List<String>? bulletList3;

  const NewsInformation({
    required this.dateNum,
    required this.dateWord,
    required this.title,
    required this.status,
    required this.paragraph1,
    this.imageDirectory,
    this.headLine1,
    this.bulletList1,
    this.headLine2,
    this.bulletList2,
    this.headLine3,
    this.bulletList3,
  });
}
