import 'package:winners/user_app/core/constants/strings.dart';
import 'package:winners/user_app/core/constants/theme.dart';

import 'package:winners/user_app/data/models/sport_type/datum.dart';
import 'package:winners/user_app/presentation/notifiers/home_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:winners/user_app/presentation/pages/app_bar/app_bar.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VirtualPage extends StatelessWidget {
  const VirtualPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeNotifier = Provider.of<HomeNotifier>(context, listen: true);
        final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);
    ThemeData theme=isDarkTheme?AppThemes().darkTheme:AppThemes().lightTheme;

    return Scaffold(
      appBar: _virtualAppBar(context, homeNotifier),
      backgroundColor: theme.primaryColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(
            height: 8,
          ),
          ...homeNotifier.virtualSportTypes.data!
              .map((e) => _item(context, e, homeNotifier))
              .toList(),
        ],
      ),
    );
  }

  Padding _item(
    BuildContext context,
    Datum sportType,
    HomeNotifier homeNotifier,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: const Icon(
          Icons.star,
        ),
        trailing: const Icon(
          Icons.chevron_right,
        ),
        title: Text(
          sportType.sport!.sportDisplayName!,
          style: GoogleFonts.poppins(),
        ),
        onTap: () {
          // homeNotifier.setVirtualFeedId(sportType.feed!.feedId);
          homeNotifier.setVirtualFeedId(
            sportType.feed!.feedId!,
          );
          homeNotifier.setVirtualSportId(
              sportType.sport!.sportId!, sportType.sport!);
          homeNotifier.setShowVirtualMatches(true);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     // epl
          //     builder: (context) => VirtualMatchesPage(
          //       title: sportType.sport!.sportDisplayName!,
          //     ),
          //   ),
          // );
        },
      ),
    );
  }

  WinnersAppBar _virtualAppBar(
      BuildContext context, HomeNotifier homeNotifier) {
    return WinnersAppBar(
      title: Strings.virtual,
      onBack: () {
        homeNotifier.setFeedId(homeNotifier.feedIndex);
        homeNotifier.setVirtualFeedId(homeNotifier.feedIndex);
        homeNotifier.invokeWithDate();
        // Navigator.pop(context);
        homeNotifier.setShowVirtualSportType(false);
      },
    );
  }
}
