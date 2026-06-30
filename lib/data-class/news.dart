import 'package:myapp/data-class/constants/month_enum.dart';
import 'package:myapp/data-class/constants/news_status_enum.dart';
import 'package:myapp/data-class/constants/year_enum.dart';

class News {
  final int primaryKey;
  final Month month;
  final int day;
  final Year year;
  final String title;
  final NewsStatus status;
  final List<String> paragraph1;
  final String? imageDirectory;
  final String? headline1;
  final String? subline1;
  final String? headline2;
  final String? subline2;
  final List<String>? primaryList;
  final String? headline3;
  final String? subline3;
  final List<String>? secondaryList;

  const News({
    required this.primaryKey,
    required this.month,
    required this.day,
    required this.year,
    required this.title,
    required this.status,
    required this.paragraph1,
    this.imageDirectory,
    this.headline1,
    this.subline1,
    this.headline2,
    this.primaryList,
    this.subline2,
    this.headline3,
    this.subline3,
    this.secondaryList,
  });

  News copyWith({
    Month? month,
    int? day,
    Year? year,
    String? title,
    NewsStatus? status,
    List<String>? paragraph1,
    String? imageDirectory,
    String? headline1,
    String? subline1,
    String? headline2,
    String? subline2,
    List<String>? primaryList,
    String? headline3,
    String? subline3,
    List<String>? secondaryList,
  }) {
    return News(
      primaryKey: primaryKey,
      month: month ?? this.month,
      day: day ?? this.day,
      year: year ?? this.year,
      title: title ?? this.title,
      status: status ?? this.status,
      paragraph1: paragraph1 ?? this.paragraph1,
      imageDirectory: imageDirectory ?? this.imageDirectory,
      headline1: headline1 ?? this.headline1,
      subline1: subline1 ?? this.subline1,
      headline2: headline2 ?? this.headline2,
      subline2: subline2 ?? this.subline2,
      primaryList: primaryList ?? this.primaryList,
      headline3: headline3 ?? this.headline3,
      subline3: subline3 ?? this.subline3,
      secondaryList: secondaryList ?? this.secondaryList,
    );
  }
}
