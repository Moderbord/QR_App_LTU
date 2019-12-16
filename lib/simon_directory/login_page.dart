import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix1;
import 'package:shared_preferences/shared_preferences.dart';
import "sign_in.dart";
import "first_screen.dart";

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  setGuest(bool b) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool("isguest", b);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 100.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(Icons.not_listed_location,
                  size: 150, color: Theme.of(context).accentColor),
              Text(
                "ThinQRight",
                style: TextStyle(fontSize: 30.0),
              ),
              SizedBox(height: 100.0),
              _signInButton(),
              _signInGuest(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      onPressed: () {
        signInWithGoogle().whenComplete(
          () {
            setState(() {
              setGuest(false);
            });
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FirstScreen();
                },
              ),
            );
          },
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/images/google_logo.png"), height: 20),
            Padding(
                padding: EdgeInsets.only(left: 10),
                child:
                    Text("Sign in with Google", style: TextStyle(fontSize: 15)))
          ],
        ),
      ),
    );
  }

  Widget _signInGuest() {
    return OutlineButton(
      onPressed: () {
        setState(() {
          email = "Guest";
          name = "Guest";
          profileImage = Image(
            image: AssetImage("assets/images/guest.png"),
          );
          setGuest(true);
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return FirstScreen();
            },
          ),
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.account_circle, color: Theme.of(context).accentColor),
            Padding(
                padding: EdgeInsets.only(left: 10),
                child:
                    Text("Sign in as Guest", style: TextStyle(fontSize: 15))),
            Padding(
              padding: EdgeInsets.only(left: 20),
            ),
          ],
        ),
      ),
    );
  }
}
