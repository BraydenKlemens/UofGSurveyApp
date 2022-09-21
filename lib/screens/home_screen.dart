import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/widgets/complete_tile.dart';
import 'package:survey_app/widgets/filter_complete.dart';
import 'package:survey_app/widgets/survey_tile.dart';
import '../providers/app_provider.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Surveys', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
        backgroundColor: const Color.fromARGB(255, 26, 25, 25),
        actions: [
          IconButton(onPressed:() => Provider.of<AppProvider>(context, listen:false).updateUserData(), icon: const Icon(Icons.refresh))
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, appState,_) {
          var surveys = appState.surveys;
          var completed = appState.completeSurveys;
          if(surveys.isNotEmpty || completed.isNotEmpty){
            return ListView( //Make this a ListView.builder() so it only renders the surveys on screen
              children: [
                //incomplete surveys
                for(int i = 0; i < surveys.length; i++)
                  SurveyTile(survey: surveys[i], index: i),

                //Show complete surveys or not
                FilterComplete(showCompleted: appState.showCompleted),

                //Complete surveys
                if (completed.isNotEmpty)
                  for(int i = 0; i < completed.length; i++)
                    Visibility(
                      visible: appState.showCompleted,
                      child: CompleteSurveyTile(survey: completed[i], index: i)
                    ),
                if (completed.isEmpty && appState.showCompleted)
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('No Surveys Complete', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  )
              ],
            );
          }else{
            return const Center(
              child: Text(
                'NO SURVEYS', 
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold
                )
              )
            );
          }
        },
      )
    );
  }
}