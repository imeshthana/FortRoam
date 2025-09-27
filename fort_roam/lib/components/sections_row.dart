import 'package:flutter/material.dart';
import 'package:fort_roam/components/section_icon_button.dart';
import 'package:fort_roam/screens/activity_screen.dart';
import 'package:fort_roam/screens/commercial_screen.dart';
import 'package:fort_roam/screens/history_screen.dart';
import 'package:fort_roam/screens/services_screen.dart';

class SectionsRow extends StatelessWidget {
  const SectionsRow({super.key, required this.data});

  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(children: [
        SectionIconButton(
          route: HistoryScreen(data: data),
          icon: Icons.account_balance,
          section: 'History',
        ),
        SectionIconButton(
          route: CommercialScreen(data: data),
          icon: Icons.restaurant,
          section: 'Local',
        ),
        SectionIconButton(
          route: ActivityScreen(data: data),
          icon: Icons.directions_run,
          section: 'Activity',
        ),
        SectionIconButton(
          route: ServicesScreen(
            data: data,
          ),
          icon: Icons.safety_check,
          section: 'Services',
        ),
      ]),
    );
  }
}
