import '/provider/user_details_viewmodel.dart';
import '/screens/matches/repository/model/matchesResult.dart';
import '/screens/matches/repository/model/roundData.dart';
import '/screens/matches/repository/model/sportData.dart';
import '/screens/matches/view/scoresScreenUI/widgets/sport_event_cards/completed_multiple_college_no_result.dart';
import '/screens/matches/view/scoresScreenUI/widgets/sport_event_cards/completed_no_score.dart';
import '/screens/matches/view/scoresScreenUI/widgets/sport_event_cards/completed_score.dart';
import '/screens/matches/view/scoresScreenUI/widgets/sport_event_cards/completed_winner123.dart';
import '/screens/matches/view/scoresScreenUI/widgets/sport_event_cards/upcoming_college.dart';
import '/screens/matches/view/scoresScreenUI/widgets/sport_event_cards/upcoming_empty.dart';
import '/screens/matches/view/scoresScreenUI/widgets/sport_event_cards/upcoming_multiple_college.dart';
import '/screens/matches/view_model/misc_events_view_model.dart';
import '/utils/error_messages.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../repository/retrofit/getAllMatches.dart';

class MatchesViewModel {
  Future<void> updateMatchesResult() async {
    MatchesResult.error = null;
    final dio = Dio();
    String? jwt = UserDetailsViewModel.userDetails.JWT;
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = MatchesRestClient(dio);
    MatchesResult.roundsList =
        await client.getAllMatches("JWT ${jwt!}").then((it) {
      return it;
    }).catchError((Object obj) {
      try {
        final res = (obj as DioError).response;
        MatchesResult.error = res?.statusCode.toString();
        if (res?.statusCode == null || res == null) {
          MatchesResult.error = ErrorMessages.noInternet;
        } else {
          MatchesResult.error = MiscEventsViewModel.matchesErrorResponse(
              res.statusCode, res.statusMessage);
        }
      } catch (e) {
        MatchesResult.error = ErrorMessages.unknownError;
      }
      return MatchesResult.roundsList ?? <RoundData>[];
    });
    MatchesResult.sportsList = await client.getAllSports("JWT $jwt").then((it) {
      return it;
    }).catchError((Object obj) {
      if (MatchesResult.error != null) {
        try {
          final res = (obj as DioError).response;
          MatchesResult.error = res?.statusCode.toString();
          if (res?.statusCode == null || res == null) {
            MatchesResult.error = ErrorMessages.noInternet;
          } else {
            MatchesResult.error = MiscEventsViewModel.matchesErrorResponse(
                res.statusCode, res.statusMessage);
          }
        } catch (e) {
          MatchesResult.error = ErrorMessages.unknownError;
        }
      }
      return MatchesResult.sportsList ?? <SportsData>[];
      //return MatchesResult.sportsList;
    });
    if (MatchesResult.sportsList != null) {
      MatchesResult.upcomingEvents = null;
      int treshold = 60; // minutes
      for (int i = 0; i < MatchesResult.roundsList!.length; i++) {
        if ((MatchesResult.roundsList![i].timestamp) == null) {
          continue;
        } else {
          double minutesUntilEvent =
              ((DateTime.parse(MatchesResult.roundsList![i].timestamp!))
                          .millisecondsSinceEpoch -
                      (DateTime.now().millisecondsSinceEpoch)) /
                  60000;
          if (minutesUntilEvent < treshold && minutesUntilEvent >= 0) {
            MatchesResult.upcomingEvents == null
                ? MatchesResult.upcomingEvents = [MatchesResult.roundsList![i]]
                : MatchesResult.upcomingEvents!
                    .add(MatchesResult.roundsList![i]);
          }
        }
      }
    }
  }

  List<List<List<RoundData>>> _commonFunctionSearchScoresFilter(
      List<RoundData> fullList) {
    List<RoundData> upcomingBoysSportsList = [];
    List<RoundData> upcomingGirlsSportsList = [];
    List<RoundData> upcomingMixedSportsList = [];
    List<RoundData> completedGirlsSportsList = [];
    List<RoundData> completedBoysSportsList = [];
    List<RoundData> completedMixedSportsList = [];
    List<List<RoundData>> boysSportsList = [
      upcomingBoysSportsList,
      completedBoysSportsList
    ];
    List<List<RoundData>> girlsSportsList = [
      upcomingGirlsSportsList,
      completedGirlsSportsList
    ];
    List<List<RoundData>> mixedSportsList = [
      upcomingMixedSportsList,
      completedMixedSportsList
    ];
    List<List<RoundData>> allGenderSportsList = [
      upcomingMixedSportsList,
      completedMixedSportsList
    ];

    List<List<List<RoundData>>> filteredListRoundData = [
      boysSportsList,
      girlsSportsList,
      mixedSportsList,
      allGenderSportsList
    ];
    if (fullList == []) {
      return filteredListRoundData;
    } else {
      for (int i = 0; i < fullList.length; i++) {
        if (fullList[i].gender == 'M') {
          if (fullList[i].timestamp == null) {
            continue;
          } else {
            if (DateTime.parse(fullList[i].timestamp!).millisecondsSinceEpoch >
                DateTime.now().millisecondsSinceEpoch) {
              (filteredListRoundData[0])[0].add(fullList[i]);
            } else {
              (filteredListRoundData[0])[1].add(fullList[i]);
            }
          }
        } else if (fullList[i].gender == 'F') {
          if (fullList[i].timestamp == null) {
            continue;
          } else {
            if (DateTime.parse(fullList[i].timestamp!).millisecondsSinceEpoch >
                DateTime.now().millisecondsSinceEpoch) {
              (filteredListRoundData[1])[0].add(fullList[i]);
            } else {
              (filteredListRoundData[1])[1].add(fullList[i]);
            }
          }
        } else {
          if (fullList[i].timestamp == null) {
            continue;
          } else {
            if (DateTime.parse(fullList[i].timestamp!).millisecondsSinceEpoch >
                DateTime.now().millisecondsSinceEpoch) {
              (filteredListRoundData[2])[0].add(fullList[i]);
            } else {
              (filteredListRoundData[2])[1].add(fullList[i]);
            }
          }
        }
      }
    }
    filteredListRoundData[3][0] = filteredListRoundData[0][0] +
        filteredListRoundData[1][0] +
        filteredListRoundData[2][0];
    filteredListRoundData[3][1] = filteredListRoundData[0][1] +
        filteredListRoundData[1][1] +
        filteredListRoundData[2][1];

    return filteredListRoundData;
  }

  List<RoundData> retrieveSportData(int sport_id) {
    List<RoundData> sportList = [];
    if (MatchesResult.roundsList == null) {
      return <RoundData>[];
    } else {
      for (int i = 0; i < MatchesResult.roundsList!.length; i++) {
        if (MatchesResult.roundsList![i].sport_id == sport_id) {
          sportList.add(MatchesResult.roundsList![i]);
        }
      }
    }
    return sportList;
  }

  List<List<List<RoundData>>> retrieveFilteredData(int sport_id) {
    List<RoundData> sportRoundList = retrieveSportData(sport_id);
    return _commonFunctionSearchScoresFilter(sportRoundList);
  }

  List<List<List<RoundData>>> retrieveSearchFilteredData(
      String textFieldValue) {
    textFieldValue = textFieldValue;
    List<RoundData> searchRoundList = [];
    for (int i = 0; i < MatchesResult.roundsList!.length; i++) {
      if ((MatchesResult.roundsList![i].team1_college_name != null &&
              MatchesResult.roundsList![i].team1_college_name!
                  .toLowerCase()
                  .contains(textFieldValue)) ||
          (MatchesResult.roundsList![i].team2_college_name != null &&
              MatchesResult.roundsList![i].team2_college_name!
                  .toLowerCase()
                  .contains(textFieldValue)) ||
          (MatchesResult.roundsList![i].team3_college_name != null &&
              MatchesResult.roundsList![i].team3_college_name!
                  .toLowerCase()
                  .contains(textFieldValue)) ||
          (MatchesResult.roundsList![i].team4_college_name != null &&
              MatchesResult.roundsList![i].team4_college_name!
                  .toLowerCase()
                  .contains(textFieldValue)) ||
          (MatchesResult.roundsList![i].team5_college_name != null &&
              MatchesResult.roundsList![i].team5_college_name!
                  .toLowerCase()
                  .contains(textFieldValue)) ||
          (MatchesResult.roundsList![i].team6_college_name != null &&
              MatchesResult.roundsList![i].team6_college_name!
                  .toLowerCase()
                  .contains(textFieldValue)) ||
          (MatchesResult.roundsList![i].team7_college_name != null &&
              MatchesResult.roundsList![i].team7_college_name!
                  .toLowerCase()
                  .contains(textFieldValue)) ||
          (MatchesResult.roundsList![i].team8_college_name != null &&
              MatchesResult.roundsList![i].team8_college_name!
                  .toLowerCase()
                  .contains(textFieldValue))) {
        searchRoundList.add(MatchesResult.roundsList![i]);
      }
    }

    return _commonFunctionSearchScoresFilter(searchRoundList);
  }

  static Widget getCorrectMatchwidget(RoundData roundData) {
    if ((DateTime.parse(roundData.timestamp!).millisecondsSinceEpoch >=
        DateTime.now().millisecondsSinceEpoch)) {
      if (roundData.team1_college_name == null ||
          roundData.team2_college_name == null ||
          roundData.team1_college_name!.isEmpty ||
          roundData.team2_college_name!.isEmpty) {
        return UpcomingEmptyCard(
          roundData: roundData,
        );
      } else if (roundData.team3_college_name != null &&
          roundData.team3_college_name!.isNotEmpty) {
        return UpcomingMultipleCollege(roundData: roundData);
      } else {
        return UpcomingCollege(
          roundData: roundData,
        );
      }
    } else {
      if (roundData.is_score == 'true') {
        return CompletedScore(roundData: roundData);
      } else if (roundData.winner2 != null && roundData.winner2!.isNotEmpty) {
        return CompletedWinner123(roundData: roundData);
      } else if (roundData.team3_college_name != null &&
          roundData.team3_college_name!.isNotEmpty) {
        return CompletedMultipleCollegeNoResult(roundData: roundData);
      } else {
        return CompletedNoScore(roundData: roundData);
      }
    }
  }
}
