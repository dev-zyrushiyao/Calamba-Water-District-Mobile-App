import 'package:myapp/data-class/news_information.dart';

class NewsData {
  //map
  final Map<String, String> _newsStatus = {
    'ongoing': 'On Going Repair',
    'resolved': 'Issue Resolved',
    'monitoring': 'Currently Monitoring',
  };

  final List<NewsInformation> _listOfNews = [];

  List<NewsInformation> _generateNewsPlaceholder() {
    List<NewsInformation> placeholderList = [];
    return placeholderList..addAll([
      NewsInformation(
        dateNum: '03-22-2026',
        dateWord: 'March-22',
        title:
            'AAAA CWD Celebrates World Water Day 2026: Glacier Preservation Awareness',
        status: _newsStatus['resolved'],
        paragraph1: ['placeholder paragraph'],
      ),

      NewsInformation(
        dateNum: '03-18-2026',
        dateWord: 'March-18',
        title: 'Water Conservation Workshop for Calamba City Public Schools',
        status: _newsStatus['ongoing'],
        paragraph1: ['placeholder paragraph'],
      ),

      NewsInformation(
        dateNum: '03-12-2026',
        dateWord: 'March-12',
        title: 'Emergency Pipe Repair: Lakeview Subd. Main Entrance',
        status: _newsStatus['ongoing'],
        paragraph1: ['placeholder paragraph'],
      ),

      NewsInformation(
        dateNum: '03-09-2026',
        dateWord: 'March-09',
        title: '"Walk In Her Shoes" Activity Honors Women in the Water Sector',
        status: _newsStatus['ongoing'],
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
        status: _newsStatus['ongoing'],
        paragraph1: [
          'The Calamba Water District (CWD) has issued an urgent advisory following a major pipe burst reported early this morning at the Main Entrance of Lakeview Subdivision.',
          'The rupture was identified in a primary 8-inch distribution line, causing significant water loss and localized flooding near the subdivision gates.',
          'CWD emergency response crews were dispatched at 8:30 AM and are currently on-site performing excavation and pipe replacement.',
        ],
        imageDirectory: 'assets/news-image/mar-25-2026-news.jpg',
        headLine1: {
          "headline": 'Service Impact',
          "subheadline":
              'Residents in the following areas may experience low pressure to zero water supply during the repair period:',
        },
        bulletList1: [
          'Lakeview Subdivision (All Phases)',
          'Portions of Brgy. Halang',
          'Immediate neighboring residential compounds',
        ],
        headLine2: {
          "headline": "Restoration Timeline",
          "subheadline":
              "CWD engineers estimate that repairs will be completed and water pressure will begin to normalize by 6:00 PM today, March 12, 2026.",
        },
        headLine3: {"headline": "Advice for Residents", "subheadline": null},
        bulletList3: [
          'Storage: Residents are encouraged to use stored water wisely until service is restored.',
          'Water Quality: Upon restoration, "turbidity" (brownish water) may occur briefly. Please let your faucets run for 1–2 minutes until the water clears.',
          'Traffic: Motorists are advised to take alternate routes as one lane near the Lakeview Main Entrance is partially obstructed by service vehicles and equipment.',
        ],
      ),
      //unpack the placeholder items
      ...placeholderNews,
    ]);

    return _listOfNews;
  }
}
