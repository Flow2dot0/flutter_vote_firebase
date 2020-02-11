
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vote_firebase/state/vote.dart';
import 'package:flutter_vote_firebase/models/vote.dart';

class VoteListWidget extends StatelessWidget{

  Function getAlternate({int start = 0}){
    int indexNum = start;

    Color getColor(){
      Color color = Colors.teal[100];

      if(indexNum % 2 == 0){
        color = Colors.blueAccent[100];
      }
      ++indexNum;
      return color;
    }

    return getColor;
  }

  @override
  Widget build(BuildContext context) {

    Function alternateColor = getAlternate(start: 0);
    String activeVoteId = Provider.of<VoteState>(context,).activeVote?.voteId ?? '';

    // TODO: implement build
    return Consumer<VoteState>(
      builder: (context, voteState, child){
        return Column(
          children: <Widget>[
            for(Vote vote in voteState.voteList)
              Card(
                color: activeVoteId == vote.voteId ? Colors.red[200] : alternateColor(),
                child: ListTile(
                  selected: activeVoteId == vote.voteId ? true : false,
                  onTap: (){
                    Provider.of<VoteState>(context, listen: false).activeVote = vote;
                  },
                  title: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      vote.voteTitle,
                      style: TextStyle(
                        fontSize: 18,
                        color: activeVoteId == vote.voteId ? Colors.white : Colors.black,
                        fontWeight: activeVoteId == vote.voteId ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
