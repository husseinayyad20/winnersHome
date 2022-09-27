import 'package:winners/user_app/data/models/sports_categories/sport_category.dart';
import 'package:winners/user_app/data/models/sports_categories/sport_top_league.dart';
import 'package:equatable/equatable.dart';

class SportCategoryDataEntity extends Equatable {
  final List<SportCategory>? sportCategories;
  final List<SportTopLeague>? sportTopLeagues;
  final dynamic id;

  const SportCategoryDataEntity({
    this.sportCategories,
    this.sportTopLeagues,
    this.id,
  });

  @override
  List<Object?> get props => [sportCategories, sportTopLeagues, id];
}
