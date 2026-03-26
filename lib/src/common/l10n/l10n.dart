import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Matchmaker'**
  String get appTitle;

  /// Label for the single match mode
  ///
  /// In en, this message translates to:
  /// **'Single match'**
  String get singleMatch;

  /// Button label to create a new event
  ///
  /// In en, this message translates to:
  /// **'Create new event'**
  String get createNewEvent;

  /// Message displayed when no events are found in the list
  ///
  /// In en, this message translates to:
  /// **'No events found'**
  String get noEventsFound;

  /// Summary of an event's completion date
  ///
  /// In en, this message translates to:
  /// **'Event finished on {date}'**
  String eventFinishedOn(String date);

  /// Information message when no game is active
  ///
  /// In en, this message translates to:
  /// **'No game in progress'**
  String get noGameInProgress;

  /// Label for event settings menu or screen
  ///
  /// In en, this message translates to:
  /// **'Event settings'**
  String get eventSettings;

  /// Action to revert the team generation
  ///
  /// In en, this message translates to:
  /// **'Undo teams'**
  String get undoTeams;

  /// Action to regenerate teams for the event
  ///
  /// In en, this message translates to:
  /// **'Regenerate teams'**
  String get regenerateTeams;

  /// Action to save the event details
  ///
  /// In en, this message translates to:
  /// **'Save event'**
  String get saveEvent;

  /// Success message when an event is saved
  ///
  /// In en, this message translates to:
  /// **'Event saved successfully!'**
  String get eventSavedSuccess;

  /// Action to import players from a raw text list
  ///
  /// In en, this message translates to:
  /// **'Import players from list'**
  String get importPlayersFromList;

  /// Title for the import players dialog
  ///
  /// In en, this message translates to:
  /// **'Import Players'**
  String get importPlayers;

  /// Label for the text area where player names are pasted
  ///
  /// In en, this message translates to:
  /// **'Player List'**
  String get playerList;

  /// Button label to confirm import
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importLabel;

  /// Action to add a single player manually
  ///
  /// In en, this message translates to:
  /// **'Add player'**
  String get addPlayer;

  /// Action to start the team distribution process
  ///
  /// In en, this message translates to:
  /// **'Generate teams'**
  String get generateTeams;

  /// Message shown when an event has no teams yet
  ///
  /// In en, this message translates to:
  /// **'No teams registered in the event'**
  String get noTeamsRegistered;

  /// Instructional message for the user to add players
  ///
  /// In en, this message translates to:
  /// **'Add players to create teams'**
  String get addPlayersToCreateTeams;

  /// Label showing the number of players
  ///
  /// In en, this message translates to:
  /// **'Players ({count})'**
  String playersCount(int count);

  /// Label showing the number of teams
  ///
  /// In en, this message translates to:
  /// **'Teams ({count})'**
  String teamsCount(int count);

  /// Title for a dialog when there are not enough players
  ///
  /// In en, this message translates to:
  /// **'Player missing!'**
  String get playerMissing;

  /// Title for a dialog when a team reaches the win limit
  ///
  /// In en, this message translates to:
  /// **'Maximum wins reached!'**
  String get maxWinsReached;

  /// General settings label
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Label for exploring past matches
  ///
  /// In en, this message translates to:
  /// **'Match history'**
  String get matchHistory;

  /// Label for the screen to manually adjust team members
  ///
  /// In en, this message translates to:
  /// **'Adjust teams'**
  String get adjustTeams;

  /// Action to finalize and close the current event
  ///
  /// In en, this message translates to:
  /// **'End event'**
  String get endEvent;

  /// Confirmation question title for ending an event
  ///
  /// In en, this message translates to:
  /// **'End event?'**
  String get endEventQuestion;

  /// Warning message before ending an event
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to end this event?\n\nAll ongoing matches will be canceled.{hasNoEndedMatches, select, true{\n\nThis event has no finished matches, so it will be completely deleted!} other{}}\n\nThis action cannot be undone!\n\nDo you want to proceed?'**
  String endEventConfirmation(String hasNoEndedMatches);

  /// Generic negative response label
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Generic positive response label
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// Status or title indicating the event has ended
  ///
  /// In en, this message translates to:
  /// **'Event closed'**
  String get eventClosed;

  /// Success message after closing an event
  ///
  /// In en, this message translates to:
  /// **'The event was closed successfully!'**
  String get eventClosedSuccess;

  /// Section header for the active game
  ///
  /// In en, this message translates to:
  /// **'Current Match'**
  String get currentMatch;

  /// Header for the end-of-event leaderboard
  ///
  /// In en, this message translates to:
  /// **'Final score'**
  String get finalScore;

  /// Label for a team
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get team;

  /// Abbreviation for Wins in a score table
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get winsAbbreviation;

  /// Abbreviation for Defeats/Losses in a score table
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get lossesAbbreviation;

  /// Label for the upcoming match
  ///
  /// In en, this message translates to:
  /// **'Next Game'**
  String get nextGame;

  /// Description of the next match prerequisites
  ///
  /// In en, this message translates to:
  /// **'Winner of {matchName} vs. {teamName}'**
  String nextGameDescription(String matchName, String teamName);

  /// Label showing the size of the waitlist queue
  ///
  /// In en, this message translates to:
  /// **'Next Teams ({count})'**
  String nextTeamsCount(int count);

  /// Action to manually register a new team
  ///
  /// In en, this message translates to:
  /// **'Add team'**
  String get addTeam;

  /// Title for the team registration screen
  ///
  /// In en, this message translates to:
  /// **'Register Team'**
  String get registerTeam;

  /// Validation error when no team name is chosen
  ///
  /// In en, this message translates to:
  /// **'Select a name for the team!'**
  String get selectTeamNameError;

  /// Placeholder for dropdown menus
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get selectPlaceholder;

  /// Label for team name input field
  ///
  /// In en, this message translates to:
  /// **'Team Name'**
  String get teamNameLabel;

  /// General label for a list of players
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get playersLabel;

  /// Success message after creating a team
  ///
  /// In en, this message translates to:
  /// **'Team registered successfully!'**
  String get teamRegisteredSuccess;

  /// Button label to save the team
  ///
  /// In en, this message translates to:
  /// **'Save Team'**
  String get saveTeam;

  /// Title for the match completion screen or dialog
  ///
  /// In en, this message translates to:
  /// **'End of match'**
  String get endOfMatch;

  /// Congratulatory message after a match
  ///
  /// In en, this message translates to:
  /// **'Team [b]{teamName}[/b] won the match by [b]{score}[/b]!\n\nConfirm and go to next match?'**
  String matchWonMessage(String teamName, String score);

  /// Button to cancel match completion and revert score
  ///
  /// In en, this message translates to:
  /// **'No, revert!'**
  String get noRevert;

  /// Button to confirm match outcome
  ///
  /// In en, this message translates to:
  /// **'Yes, confirm!'**
  String get yesConfirm;

  /// Interrogative message after a match ends
  ///
  /// In en, this message translates to:
  /// **'Do you want to start a new match?'**
  String get startNewMatchQuestion;

  /// Label for the score limit setting
  ///
  /// In en, this message translates to:
  /// **'Amount of points to win'**
  String get pointsToWinLabel;

  /// Label for the mercy rule setting
  ///
  /// In en, this message translates to:
  /// **'Eliminate at half?'**
  String get eliminateAtHalf;

  /// Summary of the mercy rule score
  ///
  /// In en, this message translates to:
  /// **'Eliminates at {score} x 0.'**
  String eliminateAtHalfDescription(int score);

  /// Generic confirmation button label
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// Dynamic title for host event settings
  ///
  /// In en, this message translates to:
  /// **'Event Settings{status, select, finished{ (Finished)} other{}}'**
  String eventSettingsTitle(String status);

  /// General label for name input
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// Label for event name input
  ///
  /// In en, this message translates to:
  /// **'Event Name'**
  String get eventNameLabel;

  /// Generic label for numeric input hint
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantityLabel;

  /// Label for team size configuration
  ///
  /// In en, this message translates to:
  /// **'Amount of players per team'**
  String get playersPerTeamLabel;

  /// Label for win streak limit configuration
  ///
  /// In en, this message translates to:
  /// **'Maximum wins in a row'**
  String get maxWinsInARowLabel;

  /// Mercy rule description with dynamic score
  ///
  /// In en, this message translates to:
  /// **'Eliminates the team that is losing by {score} x 0.'**
  String eliminateAtHalfSubtitle(int score);

  /// Label for gender balance toggle
  ///
  /// In en, this message translates to:
  /// **'Balance by gender?'**
  String get balanceByGender;

  /// Explanatory text for gender balancing
  ///
  /// In en, this message translates to:
  /// **'Same amount of men and women per team.'**
  String get balanceByGenderSubtitle;

  /// Label for skill level balance toggle
  ///
  /// In en, this message translates to:
  /// **'Balance by level?'**
  String get balanceByLevel;

  /// Explanatory text for level balancing
  ///
  /// In en, this message translates to:
  /// **'Same amount of players per level per team.'**
  String get balanceByLevelSubtitle;

  /// Button to persist configuration changes
  ///
  /// In en, this message translates to:
  /// **'Save settings'**
  String get saveSettings;

  /// Title for the player creation view
  ///
  /// In en, this message translates to:
  /// **'Register Player'**
  String get registerPlayer;

  /// Title for the player update view
  ///
  /// In en, this message translates to:
  /// **'Edit Player'**
  String get editPlayer;

  /// Validation error for missing player name
  ///
  /// In en, this message translates to:
  /// **'Player name is required!'**
  String get playerNameRequired;

  /// Input label for player name
  ///
  /// In en, this message translates to:
  /// **'Player name'**
  String get playerNameLabel;

  /// Input hint for player name
  ///
  /// In en, this message translates to:
  /// **'Enter player name'**
  String get playerNameHint;

  /// Validation error for missing gender
  ///
  /// In en, this message translates to:
  /// **'Player gender is required!'**
  String get playerGenderRequired;

  /// Selection label for male gender
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// Selection label for female gender
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// Error message when gender validation fails
  ///
  /// In en, this message translates to:
  /// **'Failed to validate player gender!'**
  String get validateGenderError;

  /// Validation error for missing skill level
  ///
  /// In en, this message translates to:
  /// **'Player level is required!'**
  String get playerLevelRequired;

  /// Error message when skill level validation fails
  ///
  /// In en, this message translates to:
  /// **'Failed to validate player level!'**
  String get validateLevelError;

  /// Generic save button label
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveLabel;

  /// Confirmation title for team deletion
  ///
  /// In en, this message translates to:
  /// **'Remove Team?'**
  String get removeTeamQuestion;

  /// Generic cancel button label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Generic remove button label
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// General label for a list of teams
  ///
  /// In en, this message translates to:
  /// **'Teams'**
  String get teamsLabel;

  /// Title for the match history screen with count
  ///
  /// In en, this message translates to:
  /// **'Match History ({count})'**
  String matchHistoryCount(int count);

  /// Information message when the history is empty
  ///
  /// In en, this message translates to:
  /// **'No matches found'**
  String get noMatchesFound;

  /// Indication in a log that a point was undone
  ///
  /// In en, this message translates to:
  /// **'Point reversed'**
  String get pointReversed;

  /// Default name generated for a new event
  ///
  /// In en, this message translates to:
  /// **'Event of the day {date}'**
  String defaultEventName(String date);

  /// Error message when trying to balance by gender without enough data
  ///
  /// In en, this message translates to:
  /// **'To generate a gender-balanced event, all players must have a defined gender!'**
  String get balanceByGenderError;

  /// Error message when there are too few players for even 2 teams
  ///
  /// In en, this message translates to:
  /// **'It is not possible to generate events with less than 2 teams!'**
  String get minTeamsError;

  /// Restriction for saving an event with very few teams
  ///
  /// In en, this message translates to:
  /// **'The event needs at least 3 teams to be generated!'**
  String get minTeamsSaveError;

  /// Error message for invalid player operations
  ///
  /// In en, this message translates to:
  /// **'Invalid player!'**
  String get invalidPlayerError;

  /// Error message for empty or malformed player import lists
  ///
  /// In en, this message translates to:
  /// **'No players found in the pasted list!'**
  String get noPlayersInListError;

  /// Warning when trying to delete more teams than allowed
  ///
  /// In en, this message translates to:
  /// **'The event has reached the minimum amount of teams!'**
  String get minTeamsWarning;

  /// Error when adding a player who is already on a team
  ///
  /// In en, this message translates to:
  /// **'Player already registered in another team!'**
  String get playerAlreadyInTeamError;

  /// Message explaining the win streak rotation rule
  ///
  /// In en, this message translates to:
  /// **'Team [b]{teamName}[/b] reached the maximum number of consecutive wins [b]({maxWins})[/b].\n\nIt will now make room for the next team and return to the queue with priority for the next match!\n\nNext match:\n[b]{nextTeam1}[/b] vs. [b]{nextTeam2}[/b]!'**
  String maxWinsInARowMessage(
    String teamName,
    int maxWins,
    String nextTeam1,
    String nextTeam2,
  );

  /// Error when a match cannot start due to missing players
  ///
  /// In en, this message translates to:
  /// **'Team [b]{teamName}[/b] is incomplete and needs [b]{count}[/b] players to play the next match!'**
  String teamIncompleteError(String teamName, int count);

  /// Error message for failed share operations
  ///
  /// In en, this message translates to:
  /// **'Error sharing event!'**
  String get shareEventError;

  /// Title displaying the team name
  ///
  /// In en, this message translates to:
  /// **'Team {name}'**
  String teamNameTitle(String name);

  /// Validation error for player list names
  ///
  /// In en, this message translates to:
  /// **'All players must have a name'**
  String get allPlayersMustHaveName;

  /// Validation error for player list genders
  ///
  /// In en, this message translates to:
  /// **'All players must have a gender defined'**
  String get allPlayersMustHaveGender;

  /// Title displaying the match identifier
  ///
  /// In en, this message translates to:
  /// **'Match {name}'**
  String matchNameTitle(String name);

  /// Warning message before removing a team
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove team [b]{teamName}[/b] from this event?\n\nThis action cannot be undone!'**
  String removeTeamConfirmation(String teamName);

  /// Success notification after adjusting teams
  ///
  /// In en, this message translates to:
  /// **'Players swapped successfully!'**
  String get playersSwappedSuccess;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return L10nEn();
    case 'pt':
      return L10nPt();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
