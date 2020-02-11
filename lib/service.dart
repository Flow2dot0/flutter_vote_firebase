import 'package:flutter_vote_firebase/models/vote.dart';
import 'package:uuid/uuid.dart';

List<Vote> getVoteList(){
  // Mock Data
  List <Vote> voteList = List<Vote>();
  
  voteList.add(Vote(
    voteId: Uuid().v4(),
    voteTitle: 'Best Mobile Frameworks ?',
    options: [
      {'Flutter': 70},
      {'React Native': 10},
      {'Xamarin': 1},
    ]
  ));

  voteList.add(Vote(
      voteId: Uuid().v4(),
      voteTitle: 'Best Web Frontend Frameworks ?',
      options: [
        {'React': 80},
        {'Angular': 40},
        {'Vue': 20},
      ]
  ));

  voteList.add(Vote(
      voteId: Uuid().v4(),
      voteTitle: 'Best Web Backend Frameworks ?',
      options: [
        {'Django': 50},
        {'Laravel': 30},
        {'Express.js': 50},
      ]
  ));

  return voteList;
}