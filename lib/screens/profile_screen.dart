import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/providers/app_provider.dart';

class ProfileScreen extends StatelessWidget {

  final double backDropHeight = 150;
  final double profileHeight = 144;

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
        backgroundColor: const Color.fromARGB(255, 26, 25, 25),
        actions: [
          IconButton(
            onPressed: (){
              Provider.of<AppProvider>(context, listen: false).signOut();
            },
            icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: ListView(
        children: [
          buildTop(),
          buildBottom(),
        ],
      )
    );
  }

  //everything below the profile picture
  Widget buildBottom() {
    return Consumer<AppProvider>(
      builder: (context, appState,_) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(appState.name != null ? appState.name! : "Profile", style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            ),
            //EVERYTHING TO THE PROFILE GETS ADDED HERE
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(thickness: 2),
            ),
            const Text('Account Settings',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            const SizedBox(height: 30),
            OutlinedButton(
              onPressed: () => openDeleteMessage(context, appState),
              child: const Text('Delete Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
            )
          ],
        );
      }
    );
  }

  //Builds a backdrop with a profile picture ontop
  Widget buildTop() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
            child: backDrop(),
            margin: EdgeInsets.only(bottom: profileHeight / 2)),
        Positioned(
            top: backDropHeight - profileHeight / 2, child: profilePicture()),
      ]
    );
  }

  Widget backDrop() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: backDropHeight,
    );
  }

  Widget profilePicture() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: profileHeight / 1.8,
          backgroundColor: const Color.fromARGB(255, 48, 48, 48),
        ),
        CircleAvatar(
          radius: profileHeight / 2,
          backgroundImage: const NetworkImage('https://eventcaddy.s3.amazonaws.com/uploads/tournament_website/logo/29/5c2de998-953c-4dc4-83ad-54a00169796d.png'),
        ),
      ]
    );
  }

  Future openDeleteMessage(BuildContext context, AppProvider appState) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete Account'),
      content:const Text('Are you sure you want to delete your account?'),
      actions: [
        TextButton(
          child: const Text('Confirm', style: TextStyle(fontSize: 18)),
          onPressed: () {
            Navigator.of(context).pop();
            appState.deleteAccout();
          },
        )
      ]
    ),
  );

}