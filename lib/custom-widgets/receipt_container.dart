import 'package:flutter/material.dart';

class ReceiptContainer extends StatelessWidget {
  const ReceiptContainer({super.key, required this.actions});

  final List<Map<String, String>> actions;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF5456A7),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Column(
        spacing: 40,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Receipt',
            style: theme.textTheme.bodyLarge!.copyWith(
              color: theme.colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),

          //loop list
          for (var mapItem in actions)
            //loop the map
            for (var item in mapItem.entries)
              Row(
                // spacing: 100,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      item.key,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.value,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
