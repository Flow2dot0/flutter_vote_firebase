class Vote {
  String voteId, voteTitle;
  List<Map<String, int>> options;

  Vote({this.voteId, this.voteTitle, this.options});
}

class Voter{
  String uId, voteId;
  int markedVoteOption;
}