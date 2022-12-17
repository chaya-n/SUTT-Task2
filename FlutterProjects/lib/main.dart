import 'package:flutter/material.dart';
import 'package:flutterprojects/SelectStations.dart';
import 'package:google_sign_in/google_sign_in.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginIn(),
    );
  }
}

class LoginIn extends StatefulWidget {
  LoginIn({Key? key}) : super(key: key);

  @override
  State<LoginIn> createState() => _LoginInState();
}

class _LoginInState extends State<LoginIn> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoggedIn = false;
  late GoogleSignInAccount _userObj;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Railways'),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: Container(
        child: _isLoggedIn
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child:Image.network(_userObj.photoUrl!),
              ),
              const SizedBox(height: 20,),
              Text(_userObj.displayName!),
              const SizedBox(height: 20,),
              Text(_userObj.email),
              const SizedBox(height: 20,),
              MaterialButton(
                onPressed: () {
                  _googleSignIn.signOut().then((value) {
                    setState(() {
                      _isLoggedIn = false;
                    });
                  }).catchError((e) {});
                },
                height: 50,
                minWidth: 100,
                color: Colors.brown,
                child: const Text('Logout',style: TextStyle(color: Colors.white),),
              ),

            ],
          ),
        ) : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("RAILWAY SERVICES",
              style: TextStyle(fontSize: 32),selectionColor: Color.fromRGBO(0, 0, 0, 1.00),),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    _googleSignIn.signIn().then((userData) {
                      setState(() {
                        _isLoggedIn = true;
                        _userObj = userData!;
                        print("----------------------------------------------------------------------------------------------");
                        print(userData.runtimeType);

                      });
                      Navigator.push(context,MaterialPageRoute(builder: (context) => SelectStations(), ));
                    }).catchError((e) {
                      print(e);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown,
                    minimumSize: Size(double.infinity, 50)
                  ),
                  child: const Text('Google SignIn',style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}