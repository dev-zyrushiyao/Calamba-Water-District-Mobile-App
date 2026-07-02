import 'package:collection/collection.dart';
import 'package:myapp/models/constants/month_enum.dart';
import 'package:myapp/models/constants/news_status_enum.dart';
import 'package:myapp/models/constants/year_enum.dart';
import 'package:myapp/models/news.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_provider.g.dart';

@Riverpod(keepAlive: false)
class NewsNotifier extends _$NewsNotifier {
  @override
  List<News> build() {
    return [
      News(
        primaryKey: 4,
        month: Month.mar,
        day: 25,
        year: Year.y2026,
        title: 'Notice of Scheduled Interconnection: Brgy. Mayapa Area',
        status: NewsStatus.ongoing,
        paragraph: [
          'The Calamba Water District (CWD) has issued an urgent advisory following a major pipe burst reported early this morning at the Main Entrance of Lakeview Subdivision.',
          'The rupture was identified in a primary 8-inch distribution line, causing significant water loss and localized flooding near the subdivision gates.',
          'CWD emergency response crews were dispatched at 8:30 AM and are currently on-site performing excavation and pipe replacement.',
        ],
        imageDirectory: 'assets/news-image/mar-25-2026-news.jpg',
        headline1: 'Service Impact',
        subline1:
            'Residents in the following areas may experience low pressure to zero water supply during the repair period:',
        firstList: [
          'Lakeview Subdivision (All Phases)',
          'Portions of Brgy. Halang',
          'Immediate neighboring residential compounds',
        ],
        headline2: "Restoration Timeline",
        subline2:
            "CWD engineers estimate that repairs will be completed and water pressure will begin to normalize by 6:00 PM today, March 12, 2026.",
        headline3: "Advice for Residents",
        subline3: null,
        thirdList: [
          'Storage: Residents are encouraged to use stored water wisely until service is restored.',
          'Water Quality: Upon restoration, "turbidity" (brownish water) may occur briefly. Please let your faucets run for 1–2 minutes until the water clears.',
          'Traffic: Motorists are advised to take alternate routes as one lane near the Lakeview Main Entrance is partially obstructed by service vehicles and equipment.',
        ],
      ),
      News(
        primaryKey: 3,
        month: Month.jan,
        day: 18,
        year: Year.y2026,
        title: 'Water Conservation Workshop for Calamba City Public Schools',
        status: NewsStatus.resolved,
        paragraph: ['Placeholder paragraph'],
      ),

      News(
        primaryKey: 2,
        month: Month.jun,
        day: 24,
        year: Year.y2026,
        title: 'Emergency Pipe Repair: Lakeview Subd. Main Entrance',
        status: NewsStatus.resolved,
        paragraph: ['Placeholder paragraph'],
      ),

      News(
        primaryKey: 1,
        month: Month.feb,
        day: 12,
        year: Year.y2025,
        title: '"Walk In Her Shoes" Activity Honors Women in the Water Sector',
        status: NewsStatus.resolved,
        paragraph: ['Placeholder paragraph'],
      ),
    ];
  }

  News? retrieveNews(int primaryKey) {
    final targetNews = state.firstWhereOrNull(
      (news) => news.primaryKey == primaryKey,
    );

    if (targetNews == null) {
      throw ArgumentError('Target news is null', 'targetNews');
    }

    return targetNews;
  }

  void updateNews(News news) {
    var updatedList = List<News>.from(state);
    updatedList = updatedList
        .map(
          (currentNews) =>
              currentNews.primaryKey == news.primaryKey ? news : currentNews,
        )
        .toList();

    state = updatedList;
  }
}
