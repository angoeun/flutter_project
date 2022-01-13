
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_login_example/res/custom_colors.dart';
import 'package:google_login_example/screens/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_login_example/utils/authentication.dart';


// 회원 탈퇴 부분

Future<void> information() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: '동계현장실습',
    home: Scaffold(
      appBar: AppBar(title: Text('동계현장실습'),),
      body: InputSample3(),
    ),
  ));
}

class InputSample3 extends StatefulWidget {
  @override
  State createState() => InputSample3State();
}

class InputSample3State extends State<InputSample3> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('동계현장실습'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              SignInScreen();
            }
        ),
        backgroundColor: CustomColors.firebaseOrange,
      ),


      body: Column(
        children: <Widget>[
          Row(),
          SizedBox(height: 24.0),
          Text(
            '정말 탈퇴하시겠습니까? 닉네임/성별/지역/자기소개 저장된 정보가 모두 사라집니다.',
            style: TextStyle(
                color: CustomColors.firebaseBlack.withOpacity(0.8),
                fontSize: 14,
                letterSpacing: 0.2),
          ),

          SizedBox(height: 16.0),
          _isSigningOut
              ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
              : ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.redAccent,
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () async {
              fireStore.collection('member').doc(user.uid).delete();
              user == null;
              setState(() {
                _isSigningOut = true;
              });
              await Authentication.signOut(context: context);
              setState(() {
                _isSigningOut = false;
              });
              Navigator.of(context)
                  .pushReplacement(_routeToSignInScreen());
            },
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                '탈퇴하기',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),

        ],
        mainAxisAlignment: MainAxisAlignment.center,

      ),
    );
  }
}
