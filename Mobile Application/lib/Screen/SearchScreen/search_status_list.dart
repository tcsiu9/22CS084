import 'package:fyp_app/Screen/screen_export.dart';
import 'package:timeline_tile/timeline_tile.dart';

class SearchStatusList extends StatefulWidget {
  final Map<String, dynamic> statusList;

  const SearchStatusList({Key? key, required this.statusList})
      : assert(statusList != null),
        super(key: key);

  @override
  State<SearchStatusList> createState() => _SearchStatusListState(statusList);
}

class _SearchStatusListState extends State<SearchStatusList> {
  final Map<String, dynamic> statusList;
  late List<String> status;
  bool isProcessing = true;

  _SearchStatusListState(this.statusList);

  @override
  initState() {
    super.initState();
    status = statusList.keys.toList();
    isProcessing = true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.0,
      child: ListView.builder(
        itemBuilder: (context, index) {
          String stage = status[index];
          String? stageTime = statusList[stage];
          if (stageTime != null) {
            return TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              isFirst: (index == 0) ? true : false,
              isLast: (index == 3) ? true : false,
              indicatorStyle: const IndicatorStyle(
                width: 20,
                color: Color(0xFF27AA69),
                padding: EdgeInsets.all(6),
              ),
              endChild: SearchTile(
                title: 'Order $stage',
                message: stageTime,
              ),
              beforeLineStyle: const LineStyle(
                color: Color(0xFF27AA69),
              ),
            );
          } else {
            if (isProcessing) {
              isProcessing = false;
              return TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.1,
                isFirst: (index == 0) ? true : false,
                isLast: (index == 3) ? true : false,
                indicatorStyle: const IndicatorStyle(
                  width: 20,
                  color: Color(0xFF2B619C),
                  padding: EdgeInsets.all(6),
                ),
                endChild: SearchTile(
                  title: 'Order $stage',
                  message: 'Processing',
                  disabled: true,
                ),
                beforeLineStyle: const LineStyle(
                  color: Color(0xFF27AA69),
                ),
                afterLineStyle: const LineStyle(
                  color: Color(0xFFDADADA),
                ),
              );
            }else{
              return TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.1,
                isFirst: (index == 0) ? true : false,
                isLast: (index == 3) ? true : false,
                indicatorStyle: const IndicatorStyle(
                  width: 20,
                  color: Color(0xFFDADADA),
                  padding: EdgeInsets.all(6),
                ),
                endChild: SearchTile(
                  title: 'Order $stage',
                  message: '',
                  disabled: true,
                ),
                beforeLineStyle: const LineStyle(
                  color: Color(0xFFDADADA),
                ),
              );
            }
          }
        },
        itemCount: 4,
      ),
    );
  }
}
