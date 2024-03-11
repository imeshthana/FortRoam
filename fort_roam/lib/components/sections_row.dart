import 'package:flutter/material.dart';
import 'package:fort_roam/components/section_icon_button.dart';
import 'package:fort_roam/screens/activity_screen.dart';
import 'package:fort_roam/screens/commercial_screen.dart';
import 'package:fort_roam/screens/history_screen.dart';
import 'package:fort_roam/screens/map_screen.dart';

class SectionsRow extends StatelessWidget {
  const SectionsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(children: [
        SectionIconButton(
          route: HistoryScreen(),
          icon: Icons.account_balance,
          section: 'Historical',
        ),
        SectionIconButton(
          route: CommercialScreen(),
          icon: Icons.restaurant,
          section: 'Local',
        ),
        SectionIconButton(
          route: ActivityScreen(),
          icon: Icons.directions_run,
          section: 'Activity',
        ),
        SectionIconButton(
          route: MapScreen(),
          icon: Icons.safety_check,
          section: 'Support',
        ),
      ]),
    );
  }
}
