/*
 * Have only 2 lists, update each of them as I make changes to user
 * deleted from surveys, add to completed
 * for completed clickable section, use the completed list to build that
 * remove isCompleted bool from survey object
 * Make a seperate collection for given surveys,
 * that loads in the users surveys once the app is loaded 
 * 
 * 
 * Aside: Each of these tiles are already built just have to fill them in
 * 
 */

import 'package:flutter/material.dart';
import '../models/survey.dart';
import '../screens/survey_screen.dart';

class SurveyTile extends StatelessWidget {

  const SurveyTile({Key? key, required this.survey, required this.index}) : super(key: key);

  final int index;
  final Survey survey;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: Colors.grey[700],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => SurveyScreen(
                survey: survey,
                index: index,
              )
            ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.circle_outlined, size: 30, color: Colors.blue),
                ),
              Text(survey.title, style: const TextStyle(fontSize: 20)),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.navigate_next),
              )
            ],
          ),
        )
      )
    );
  }
}