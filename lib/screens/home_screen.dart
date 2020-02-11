import 'package:flutter/material.dart';
import 'package:flutter_vote_firebase/widgets/vote.dart';
import 'package:flutter_vote_firebase/widgets/vote_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vote_firebase/models/vote.dart';
import 'package:flutter_vote_firebase/state/vote.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentStep = 0;

  Step getStep({String title, Widget child, bool isActive = false}) {
    return Step(
        title: Text(title),
        content: child,
      isActive: isActive,
    );
  }

  bool step2Required(){
    return Provider.of<VoteState>(context, listen: false).activeVote == null ? false : true;
  }

  bool step3Required(){
    return Provider.of<VoteState>(context, listen: false).selectedOptionInActiveVote == null ? false : true;
  }

  void showSnackBar(BuildContext context, String msg){
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          msg,
          style: TextStyle(
            fontSize: 22.0,
          ),
        )
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loading votes
    Future.microtask(() {
      Provider.of<VoteState>(context, listen: false).clearState();
      Provider.of<VoteState>(context, listen: false).loadVoteList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Stepper(
              currentStep:_currentStep,
              type: StepperType.horizontal,
                steps: [
                  getStep(
                    title: 'Choose',
                    child: VoteListWidget(),
                    isActive: true,
                  ),
                  getStep(
                    title: 'Vote',
                    child: VoteWidget(),
                    isActive: _currentStep >= 1 ? true : false,
                  ),
                ],
              onStepContinue: () {
                if(_currentStep == 0){
                  if(step2Required()){
                    setState(() {
                      _currentStep = (_currentStep + 1) > 1 ? 1 : _currentStep + 1;
                    });
                  }else {
                    showSnackBar(context, 'Please select a vote first');
                  }
                } else if(_currentStep == 1 ){
                    if(step3Required()){
                      Navigator.pushReplacementNamed(context, '/result');
                    } else {
                      showSnackBar(context, 'Please mark your vote !');
                    }
                }
              },
              onStepCancel: () {
                if(_currentStep <=0){
                  Provider.of<VoteState>(context, listen: false).activeVote = null;
                } else if(_currentStep <= 1){
                  Provider.of<VoteState>(context, listen: false).selectedOptionInActiveVote = null;
                }
                setState(() {
                  _currentStep = (_currentStep - 1) < 0 ? 0 : _currentStep - 1;
                });
              },
            ),
          ),
        ],
      ),
    );
  }


}
