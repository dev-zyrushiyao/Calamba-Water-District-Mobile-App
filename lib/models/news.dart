import 'package:myapp/models/constants/month_enum.dart';
import 'package:myapp/models/constants/news_status_enum.dart';
import 'package:myapp/models/constants/year_enum.dart';

class News {
  final int primaryKey;
  final Month month;
  final int day;
  final Year year;
  final String title;
  final NewsStatus status;
  final List<String> paragraph;
  final String? imageDirectory;
  final String? headline1;
  final String? subline1;
  final List<String>? firstList;
  final String? headline2;
  final String? subline2;
  final List<String>? secondList;
  final String? headline3;
  final String? subline3;
  final List<String>? thirdList;

  const News({
    required this.primaryKey,
    required this.month,
    required this.day,
    required this.year,
    required this.title,
    required this.status,
    required this.paragraph,
    this.imageDirectory,
    this.headline1,
    this.subline1,
    this.headline2,
    this.firstList,
    this.subline2,
    this.secondList,
    this.headline3,
    this.subline3,
    this.thirdList,
  });

  News copyWith({
    Month? month,
    int? day,
    Year? year,
    String? title,
    NewsStatus? status,
    List<String>? paragraph,
    String? imageDirectory,
    String? headline1,
    String? subline1,
    String? headline2,
    String? subline2,
    List<String>? firstList,
    String? headline3,
    String? subline3,
    List<String>? secondList,
    List<String>? thirdList,
  }) {
    return News(
      primaryKey: primaryKey,
      month: month ?? this.month,
      day: day ?? this.day,
      year: year ?? this.year,
      title: title ?? this.title,
      status: status ?? this.status,
      paragraph: paragraph ?? this.paragraph,
      imageDirectory: imageDirectory ?? this.imageDirectory,
      headline1: headline1 ?? this.headline1,
      subline1: subline1 ?? this.subline1,
      headline2: headline2 ?? this.headline2,
      subline2: subline2 ?? this.subline2,
      firstList: firstList ?? this.firstList,
      headline3: headline3 ?? this.headline3,
      subline3: subline3 ?? this.subline3,
      secondList: secondList ?? this.secondList,
      thirdList: thirdList ?? this.thirdList,
    );
  }
}
