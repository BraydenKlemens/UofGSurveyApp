import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({ Key? key }) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey History', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
        backgroundColor: const Color.fromARGB(255, 26, 25, 25),
      ),
      body: Consumer<AppProvider>(
        builder: (context, appState, child) {
          var completedsurveys = appState.history;
          if(completedsurveys.isNotEmpty){
            return ListView(
              children: [
                const SizedBox(height: 3),
                for(int i = 0; i < completedsurveys.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: const Icon(Icons.check_circle),
                      title: Text(completedsurveys[i].title, style: const TextStyle(fontSize: 20)),
                      subtitle: Text(completedsurveys[i].date.toString().substring(0,19), style: const TextStyle(fontSize: 18)),
                      tileColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
                    ),
                  )
              ],
            );
          }else{
            return const Center(child: Text('NO HISTORY', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
          }
        },
        //whatever is defined here can stay the same without being rebuilt by chnages in the consumer
        //child: Text('Something'),
      )
    );
  }
}