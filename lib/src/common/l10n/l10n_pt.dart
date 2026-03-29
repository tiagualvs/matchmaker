// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class L10nPt extends L10n {
  L10nPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Matchmaker';

  @override
  String get singleMatch => 'Partida avulsa';

  @override
  String get createNewEvent => 'Criar novo evento';

  @override
  String get noEventsFound => 'Nenhum evento encontrado';

  @override
  String eventFinishedOn(String date) {
    return 'Evento finalizado em $date';
  }

  @override
  String get noGameInProgress => 'Nenhum jogo em andamento';

  @override
  String get eventSettings => 'Configurações do evento';

  @override
  String get undoTeams => 'Desfazer times';

  @override
  String get regenerateTeams => 'Regerar times';

  @override
  String get saveEvent => 'Salvar evento';

  @override
  String get eventSavedSuccess => 'Evento salvo com sucesso!';

  @override
  String get importPlayersFromList => 'Importar jogadores de lista';

  @override
  String get importPlayers => 'Importar Jogadores';

  @override
  String get playerList => 'Lista de Jogadores';

  @override
  String get importLabel => 'Importar';

  @override
  String get addPlayer => 'Adicionar jogador';

  @override
  String get generateTeams => 'Gerar times';

  @override
  String get noTeamsRegistered => 'Nenhum time cadastrado no evento';

  @override
  String get addPlayersToCreateTeams => 'Adicione jogadores para criar times';

  @override
  String playersCount(int count) {
    return 'Jogadores ($count)';
  }

  @override
  String teamsCount(int count) {
    return 'Times ($count)';
  }

  @override
  String get playerMissing => 'Jogador ausente!';

  @override
  String get maxWinsReached => 'Máximo de vitórias atingida!';

  @override
  String get settings => 'Configurações';

  @override
  String get matchHistory => 'Histórico de partidas';

  @override
  String get adjustTeams => 'Ajustar times';

  @override
  String get endEvent => 'Finalizar evento';

  @override
  String get endEventQuestion => 'Finalizar evento?';

  @override
  String endEventConfirmation(String hasNoEndedMatches) {
    String _temp0 = intl.Intl.selectLogic(
      hasNoEndedMatches,
      {
        'true':
            '\n\nEsse evento não possui partidas finalizadas, então ele será excluído por completo!',
        'other': '',
      },
    );
    return 'Tem certeza que deseja finalizar este evento?\n\nTodas as partidas em andamento serão canceladas.$_temp0\n\nEssa ação não poderá ser desfeita!\n\nDeseja prosseguir?';
  }

  @override
  String get no => 'Não';

  @override
  String get yes => 'Sim';

  @override
  String get eventClosed => 'Evento encerrado';

  @override
  String get eventClosedSuccess => 'O evento foi encerrado com sucesso!';

  @override
  String get currentMatch => 'Partida Atual';

  @override
  String get finalScore => 'Placar final';

  @override
  String get team => 'Time';

  @override
  String get winsAbbreviation => 'V';

  @override
  String get lossesAbbreviation => 'D';

  @override
  String get nextGame => 'Próximo Jogo';

  @override
  String nextGameDescription(String matchName, String teamName) {
    return 'Vencedor da $matchName vs. $teamName';
  }

  @override
  String nextTeamsCount(int count) {
    return 'Próximos Times ($count)';
  }

  @override
  String get addTeam => 'Adicionar time';

  @override
  String get registerTeam => 'Cadastrar Time';

  @override
  String get selectTeamNameError => 'Selecione um nome para o time!';

  @override
  String get selectPlaceholder => 'Selecione';

  @override
  String get teamNameLabel => 'Nome do Time';

  @override
  String get playersLabel => 'Jogadores';

  @override
  String get teamRegisteredSuccess => 'Time cadastrado com sucesso!';

  @override
  String get saveTeam => 'Salvar Time';

  @override
  String get endOfMatch => 'Fim de partida';

  @override
  String matchWonMessage(String teamName, String score) {
    return 'O time [b]$teamName[/b] venceu a partida por [b]$score[/b]!\n\nConfirmar e ir para próxima partida?';
  }

  @override
  String get noRevert => 'Não, reverter!';

  @override
  String get yesConfirm => 'Sim, confirmar!';

  @override
  String get startNewMatchQuestion => 'Deseja iniciar uma nova partida?';

  @override
  String get pointsToWinLabel => 'Quantidade de pontos para vencer';

  @override
  String get eliminateAtHalf => 'Eliminar na metade?';

  @override
  String eliminateAtHalfDescription(int score) {
    return 'Elimina no $score x 0.';
  }

  @override
  String get ok => 'Ok';

  @override
  String eventSettingsTitle(String status) {
    String _temp0 = intl.Intl.selectLogic(
      status,
      {
        'finished': ' (Finalizado)',
        'other': '',
      },
    );
    return 'Configurações do Evento$_temp0';
  }

  @override
  String get nameLabel => 'Nome';

  @override
  String get eventNameLabel => 'Nome do Evento';

  @override
  String get quantityLabel => 'Quantidade';

  @override
  String get playersPerTeamLabel => 'Quantidade de jogadores por time';

  @override
  String get maxWinsInARowLabel => 'Máximo de vitórias em sequência';

  @override
  String eliminateAtHalfSubtitle(int score) {
    return 'Elimina o time que estiver perdendo por $score x 0.';
  }

  @override
  String get balanceByGender => 'Balancear por gênero?';

  @override
  String get balanceByGenderSubtitle =>
      'Mesma quantidade de homens e mulheres por time.';

  @override
  String get balanceByLevel => 'Balancear por nível?';

  @override
  String get balanceByLevelSubtitle =>
      'Mesma quantidade de jogadores por nível por time.';

  @override
  String get saveSettings => 'Salvar configurações';

  @override
  String get registerPlayer => 'Cadastrar Jogador';

  @override
  String get editPlayer => 'Editar Jogador';

  @override
  String get playerNameRequired => 'O nome do jogador é obrigatório!';

  @override
  String get playerNameLabel => 'Nome do jogador';

  @override
  String get playerNameHint => 'Digite o nome do jogador';

  @override
  String get playerGenderRequired => 'O gênero do jogador é obrigatório!';

  @override
  String get male => 'Masculino';

  @override
  String get female => 'Feminino';

  @override
  String get validateGenderError => 'Falha ao validar gênero do jogador!';

  @override
  String get playerLevelRequired => 'O nível do jogador é obrigatório!';

  @override
  String get validateLevelError => 'Falha ao validar nível do jogador!';

  @override
  String get saveLabel => 'Salvar';

  @override
  String get removeTeamQuestion => 'Remover Time?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get remove => 'Remover';

  @override
  String get teamsLabel => 'Times';

  @override
  String matchHistoryCount(int count) {
    return 'Histórico de Partidas ($count)';
  }

  @override
  String get noMatchesFound => 'Nenhuma partida encontrada';

  @override
  String get pointReversed => 'Ponto revertido';

  @override
  String defaultEventName(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat(
      'dd/MM/yyyy',
      localeName,
    );
    final String dateString = dateDateFormat.format(date);

    return 'Evento do dia $dateString';
  }

  @override
  String get balanceByGenderError =>
      'Para gerar o evento balanceado por gênero, todos os jogadores devem ter um gênero definido!';

  @override
  String get minTeamsError =>
      'Não é possível gerar eventos com menos de 2 times!';

  @override
  String get minTeamsSaveError =>
      'O evento precisa de pelo menos 3 times para ser gerado!';

  @override
  String get invalidPlayerError => 'Jogador inválido!';

  @override
  String get noPlayersInListError =>
      'Nenhum jogador encontrado na lista colada!';

  @override
  String get minTeamsWarning => 'O evento chegou a quantidade mínima de times!';

  @override
  String get playerAlreadyInTeamError => 'Jogador já cadastrado em outro time!';

  @override
  String maxWinsInARowMessage(
    String teamName,
    int maxWins,
    String nextTeam1,
    String nextTeam2,
  ) {
    return 'O time [b]$teamName[/b] alcançou o número máximo de vitórias em sequência [b]($maxWins)[/b].\n\nAgora dará lugar ao próximo time e voltará para a fila com prioridade para jogar a próxima partida!\n\nPróximo jogo:\n[b]$nextTeam1[/b] vs. [b]$nextTeam2[/b]!';
  }

  @override
  String teamIncompleteError(String teamName, int count) {
    return 'O time [b]$teamName[/b] está incompleto e precisa de [b]$count[/b] jogadores para jogar a próxima partida!';
  }

  @override
  String get shareEventError => 'Erro ao compartilhar evento!';

  @override
  String teamNameTitle(String name) {
    return 'Time $name';
  }

  @override
  String get allPlayersMustHaveName => 'Todos os jogadores devem ter um nome';

  @override
  String get allPlayersMustHaveGender =>
      'Todos os jogadores devem ter um gênero definido';

  @override
  String matchNameTitle(String name) {
    return 'Partida $name';
  }

  @override
  String removeTeamConfirmation(String teamName) {
    return 'Tem certeza que deseja remover o time [b]$teamName[/b] deste evento?\n\nEssa ação não poderá ser desfeita!';
  }

  @override
  String get playersSwappedSuccess => 'Jogadores trocados com sucesso!';

  @override
  String get detachedFirstTeamName => 'Time A';

  @override
  String get detachedSecondTeamName => 'Time B';

  @override
  String get failedToSaveEventError => 'Falha ao salvar evento!';

  @override
  String get failedToSavePlayerError => 'Falha ao salvar jogador!';

  @override
  String get maxPlayersPerTeamError =>
      'O número máximo de jogadores por time foi atingido!';
}
