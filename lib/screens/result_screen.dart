import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_vote_firebase/state/vote.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vote_firebase/models/vote.dart';


class ResultScreen extends StatelessWidget {

  Widget createChart(BuildContext context){
    return charts.BarChart(
      retrieveVoteResult(context),
      animate: true,
    );
  }

  List<charts.Series<VoteData, String>> retrieveVoteResult(BuildContext context){
    Vote activeVote = Provider.of<VoteState>(context, listen: false).activeVote;

    List<VoteData> data = [];
    for (var option in activeVote.options){
      option.forEach((k, v) {
        data.add(VoteData(k, v));
      });
    }

    return [
      charts.Series<VoteData, String>(
        id: 'VoteResult',
        // ignore: missing_return
        colorFn: (_, pos) {
          if(pos % 2 == 0 ){
            return charts.MaterialPalette.green.shadeDefault;
        }
          return charts.MaterialPalette.blue.shadeDefault;
        },
        domainFn: (VoteData vote, _) => vote.option,
        measureFn: (VoteData vote, _) => vote.total,
        data: data
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: createChart(context),
    );
  }
}

class VoteData {
  final String option;
  final int total;

  VoteData(this.option, this.total);
}