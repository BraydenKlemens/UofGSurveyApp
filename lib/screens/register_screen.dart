import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/providers/app_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final namecontroller = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String error = '';

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    namecontroller.dispose();
    super.dispose();
  }

  void handleErrors(String error){
    if(error == 'weak-password'){
      openErrorMessage(error + ': Password must be atleast 6 characters long');
    }else if (error == 'invalid-email'){
      openErrorMessage(error + ': Email must have a proper email format');
    } else if (error == 'email-already-in-use'){
      openErrorMessage(error + ': Try loging in or using a different email');
    }else{
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('UofG Survey Hub', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
          backgroundColor: const Color.fromARGB(255, 26, 25, 25),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Create Survey Hub Account',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: namecontroller,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.account_circle),
                          hintText: 'Username',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: emailcontroller,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          hintText: 'email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter an email address to continue';
                          } 
                          return null;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passwordcontroller,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.lock),
                          hintText: 'password',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a password to continue';
                          }
                          return null;
                        },
                      )
                    ],
                  )
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Register Account', style: TextStyle(fontSize: 20)),
                  onPressed: () async {
                    if(formKey.currentState!.validate()){
                      await Provider.of<AppProvider>(context, listen: false)
                        .signUp(
                          email: emailcontroller.text.trim(),
                          password: passwordcontroller.text.trim(),
                          name: namecontroller.text.trim()
                      ).then((value) => error = value.toString());
                    }
                    //Handle errors returned from auth
                    handleErrors(error);
                  }
                ),
                const SizedBox(height: 20),
                const Divider(thickness: 2.0),
                const SizedBox(height: 20),
                const Text('Already have an account?'),
                const SizedBox(height: 20),
                OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Log In', style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Provider.of<AppProvider>(context, listen: false).changeAuth();
                  }
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  Future openErrorMessage(String error) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Error'),
      content: Text(error),
      actions: [
        TextButton(
          child: const Text('Close', style: TextStyle(fontSize: 18)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ]
    ),
  );

}