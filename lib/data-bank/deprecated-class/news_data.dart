import 'package:myapp/data-class/constants/news_status_enum.dart';
import 'package:myapp/data-class/deprecated-class/news_information.dart';

class NewsData {
  final List<NewsInformation> _listOfNews = [];

  List<NewsInformation> _generateNewsPlaceholder() {
    List<NewsInformation> placeholderList = [];
    return placeholderList..addAll([
      NewsInformation(
        dateNum: '03-22-2026',
        dateWord: 'March-22',
        title:
            'CWD Celebrates World Water Day 2026: Glacier Preservation Awareness',
        status: NewsStatus.monitoring.value,
        paragraph1: ['placeholder paragraph'],
      ),

      NewsInformation(
        dateNum: '03-18-2026',
        dateWord: 'March-18',
        title: 'Water Conservation Workshop for Calamba City Public Schools',
        status: NewsStatus.ongoing.value,
        paragraph1: ['placeholder paragraph'],
      ),

      NewsInformation(
        dateNum: '03-12-2026',
        dateWord: 'March-12',
        title: 'Emergency Pipe Repair: Lakeview Subd. Main Entrance',
        status: NewsStatus.resolved.value,
        paragraph1: ['placeholder paragraph'],
      ),

      NewsInformation(
        dateNum: '03-09-2026',
        dateWord: 'March-09',
        title: '"Walk In Her Shoes" Activity Honors Women in the Water Sector',
        status: NewsStatus.resolved.value,
        paragraph1: ['placeholder paragraph'],
      ),
    ]);
  }

  List<NewsInformation> createNews() {
    var placeholderNews = _generateNewsPlaceholder();

    _listOfNews.addAll([
      NewsInformation(
        dateNum: '03-25-2026',
        dateWord: 'March-25',
        title: 'Notice of Scheduled Interconnection: Brgy. Mayapa Area',
        status: NewsStatus.ongoing.value,
        paragraph1: [
          'The Calamba Water District (CWD) has issued an urgent advisory following a major pipe burst reported early this morning at the Main Entrance of Lakeview Subdivision.',
          'The rupture was identified in a primary 8-inch distribution line, causing significant water loss and localized flooding near the subdivision gates.',
          'CWD emergency response crews were dispatched at 8:30 AM and are currently on-site performing excavation and pipe replacement.',
        ],
      ),
      //unpack the placeholder items
      ...placeholderNews,
    ]);

    return _listOfNews;
  }
}
