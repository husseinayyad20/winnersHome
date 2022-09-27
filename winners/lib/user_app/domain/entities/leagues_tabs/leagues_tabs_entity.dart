import 'package:winners/user_app/data/models/leagues_tabs/sport_top_leagues_tab.dart';

class LeaguesTabsEntity {
  final List<LeaguesTab>? sportTopLeaguesTab;
  final int? id;
  final dynamic name;

  const LeaguesTabsEntity({this.sportTopLeaguesTab, this.id, this.name});

  List<Object?> get props => [sportTopLeaguesTab, id, name];
}
