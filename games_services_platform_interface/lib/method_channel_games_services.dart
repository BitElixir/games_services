import 'dart:async';

import 'package:flutter/services.dart';
import 'package:games_services_platform_interface/helpers.dart';
import 'package:games_services_platform_interface/models/achievement.dart';
import 'package:games_services_platform_interface/models/score.dart';

import 'game_services_platform_interface.dart';

const MethodChannel _channel = const MethodChannel("games_services");

class MethodChannelGamesServices extends GamesServicesPlatform {
  Future<String> unlock({achievement: Achievement}) async {
    return await _channel.invokeMethod("unlock", {
      "achievementID": achievement.id,
      "percentComplete": achievement.percentComplete,
    });
  }

  Future<String> submitScore({score: Score}) async {
    return await _channel.invokeMethod("submitScore", {
      "leaderboardID": score.leaderboardID,
      "value": score.value,
    });
  }

  Future<String> increment({achievement: Achievement}) async {
    return await _channel.invokeMethod("increment", {
      "achievementID": achievement.id,
      "steps": achievement.steps,
    });
  }

  Future<String> showAchievements() async {
    return await _channel.invokeMethod("showAchievements");
  }

  Future<String> showLeaderboards({iOSLeaderboardID = ""}) async {
    return await _channel.invokeMethod("showLeaderboards", {"iOSLeaderboardID": iOSLeaderboardID});
  }

  /// get the signed in players ID
  Future<String> playerID() async {
    return await _channel.invokeMethod("playerID");
  }

  /// get the signed in players display name
  Future<String> displayName() async {
    return await _channel.invokeMethod("displayName");
  }

  Future<String> signIn() async {
    if (Helpers.isPlatformAndroid) {
      return await _channel.invokeMethod("silentSignIn");
    } else {
      return await _channel.invokeMethod("signIn");
    }
  }
}
