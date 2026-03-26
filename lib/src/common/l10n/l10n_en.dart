// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Matchmaker';

  @override
  String get singleMatch => 'Single match';

  @override
  String get createNewEvent => 'Create new event';

  @override
  String get noEventsFound => 'No events found';

  @override
  String eventFinishedOn(String date) {
    return 'Event finished on $date';
  }

  @override
  String get noGameInProgress => 'No game in progress';

  @override
  String get eventSettings => 'Event settings';

  @override
  String get undoTeams => 'Undo teams';

  @override
  String get regenerateTeams => 'Regenerate teams';

  @override
  String get saveEvent => 'Save event';

  @override
  String get eventSavedSuccess => 'Event saved successfully!';

  @override
  String get importPlayersFromList => 'Import players from list';

  @override
  String get importPlayers => 'Import Players';

  @override
  String get playerList => 'Player List';

  @override
  String get importLabel => 'Import';

  @override
  String get addPlayer => 'Add player';

  @override
  String get generateTeams => 'Generate teams';

  @override
  String get noTeamsRegistered => 'No teams registered in the event';

  @override
  String get addPlayersToCreateTeams => 'Add players to create teams';

  @override
  String playersCount(int count) {
    return 'Players ($count)';
  }

  @override
  String teamsCount(int count) {
    return 'Teams ($count)';
  }

  @override
  String get playerMissing => 'Player missing!';

  @override
  String get maxWinsReached => 'Maximum wins reached!';

  @override
  String get settings => 'Settings';

  @override
  String get matchHistory => 'Match history';

  @override
  String get adjustTeams => 'Adjust teams';

  @override
  String get endEvent => 'End event';

  @override
  String get endEventQuestion => 'End event?';

  @override
  String endEventConfirmation(String hasNoEndedMatches) {
    String _temp0 = intl.Intl.selectLogic(
      hasNoEndedMatches,
      {
        'true':
            '\n\nThis event has no finished matches, so it will be completely deleted!',
        'other': '',
      },
    );
    return 'Are you sure you want to end this event?\n\nAll ongoing matches will be canceled.$_temp0\n\nThis action cannot be undone!\n\nDo you want to proceed?';
  }

  @override
  String get no => 'No';

  @override
  String get yes => 'Yes';

  @override
  String get eventClosed => 'Event closed';

  @override
  String get eventClosedSuccess => 'The event was closed successfully!';

  @override
  String get currentMatch => 'Current Match';

  @override
  String get finalScore => 'Final score';

  @override
  String get team => 'Team';

  @override
  String get winsAbbreviation => 'W';

  @override
  String get lossesAbbreviation => 'L';

  @override
  String get nextGame => 'Next Game';

  @override
  String nextGameDescription(String matchName, String teamName) {
    return 'Winner of $matchName vs. $teamName';
  }

  @override
  String nextTeamsCount(int count) {
    return 'Next Teams ($count)';
  }

  @override
  String get addTeam => 'Add team';

  @override
  String get registerTeam => 'Register Team';

  @override
  String get selectTeamNameError => 'Select a name for the team!';

  @override
  String get selectPlaceholder => 'Select';

  @override
  String get teamNameLabel => 'Team Name';

  @override
  String get playersLabel => 'Players';

  @override
  String get teamRegisteredSuccess => 'Team registered successfully!';

  @override
  String get saveTeam => 'Save Team';

  @override
  String get endOfMatch => 'End of match';

  @override
  String matchWonMessage(String teamName, String score) {
    return 'Team [b]$teamName[/b] won the match by [b]$score[/b]!\n\nConfirm and go to next match?';
  }

  @override
  String get noRevert => 'No, revert!';

  @override
  String get yesConfirm => 'Yes, confirm!';

  @override
  String get startNewMatchQuestion => 'Do you want to start a new match?';

  @override
  String get pointsToWinLabel => 'Amount of points to win';

  @override
  String get eliminateAtHalf => 'Eliminate at half?';

  @override
  String eliminateAtHalfDescription(int score) {
    return 'Eliminates at $score x 0.';
  }

  @override
  String get ok => 'Ok';

  @override
  String eventSettingsTitle(String status) {
    String _temp0 = intl.Intl.selectLogic(
      status,
      {
        'finished': ' (Finished)',
        'other': '',
      },
    );
    return 'Event Settings$_temp0';
  }

  @override
  String get nameLabel => 'Name';

  @override
  String get eventNameLabel => 'Event Name';

  @override
  String get quantityLabel => 'Quantity';

  @override
  String get playersPerTeamLabel => 'Amount of players per team';

  @override
  String get maxWinsInARowLabel => 'Maximum wins in a row';

  @override
  String eliminateAtHalfSubtitle(int score) {
    return 'Eliminates the team that is losing by $score x 0.';
  }

  @override
  String get balanceByGender => 'Balance by gender?';

  @override
  String get balanceByGenderSubtitle =>
      'Same amount of men and women per team.';

  @override
  String get balanceByLevel => 'Balance by level?';

  @override
  String get balanceByLevelSubtitle =>
      'Same amount of players per level per team.';

  @override
  String get saveSettings => 'Save settings';

  @override
  String get registerPlayer => 'Register Player';

  @override
  String get editPlayer => 'Edit Player';

  @override
  String get playerNameRequired => 'Player name is required!';

  @override
  String get playerNameLabel => 'Player name';

  @override
  String get playerNameHint => 'Enter player name';

  @override
  String get playerGenderRequired => 'Player gender is required!';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get validateGenderError => 'Failed to validate player gender!';

  @override
  String get playerLevelRequired => 'Player level is required!';

  @override
  String get validateLevelError => 'Failed to validate player level!';

  @override
  String get saveLabel => 'Save';

  @override
  String get removeTeamQuestion => 'Remove Team?';

  @override
  String get cancel => 'Cancel';

  @override
  String get remove => 'Remove';

  @override
  String get teamsLabel => 'Teams';

  @override
  String matchHistoryCount(int count) {
    return 'Match History ($count)';
  }

  @override
  String get noMatchesFound => 'No matches found';

  @override
  String get pointReversed => 'Point reversed';

  @override
  String defaultEventName(String date) {
    return 'Event of the day $date';
  }

  @override
  String get balanceByGenderError =>
      'To generate a gender-balanced event, all players must have a defined gender!';

  @override
  String get minTeamsError =>
      'It is not possible to generate events with less than 2 teams!';

  @override
  String get minTeamsSaveError =>
      'The event needs at least 3 teams to be generated!';

  @override
  String get invalidPlayerError => 'Invalid player!';

  @override
  String get noPlayersInListError => 'No players found in the pasted list!';

  @override
  String get minTeamsWarning =>
      'The event has reached the minimum amount of teams!';

  @override
  String get playerAlreadyInTeamError =>
      'Player already registered in another team!';

  @override
  String maxWinsInARowMessage(
    String teamName,
    int maxWins,
    String nextTeam1,
    String nextTeam2,
  ) {
    return 'Team [b]$teamName[/b] reached the maximum number of consecutive wins [b]($maxWins)[/b].\n\nIt will now make room for the next team and return to the queue with priority for the next match!\n\nNext match:\n[b]$nextTeam1[/b] vs. [b]$nextTeam2[/b]!';
  }

  @override
  String teamIncompleteError(String teamName, int count) {
    return 'Team [b]$teamName[/b] is incomplete and needs [b]$count[/b] players to play the next match!';
  }

  @override
  String get shareEventError => 'Error sharing event!';

  @override
  String teamNameTitle(String name) {
    return 'Team $name';
  }

  @override
  String get allPlayersMustHaveName => 'All players must have a name';

  @override
  String get allPlayersMustHaveGender =>
      'All players must have a gender defined';

  @override
  String matchNameTitle(String name) {
    return 'Match $name';
  }

  @override
  String removeTeamConfirmation(String teamName) {
    return 'Are you sure you want to remove team [b]$teamName[/b] from this event?\n\nThis action cannot be undone!';
  }

  @override
  String get playersSwappedSuccess => 'Players swapped successfully!';
}
