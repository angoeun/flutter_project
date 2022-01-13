import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_login_example/screens/register.dart';
import 'package:google_login_example/res/custom_colors.dart';
import 'package:google_login_example/screens/sign_in_screen.dart';
import 'package:google_login_example/utils/authentication.dart';
import 'package:google_login_example/widgets/app_bar_title.dart';
import 'package:google_login_example/widgets/register_edit.dart';
import 'package:google_login_example/widgets/register_delete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// 가입 완료 후
void information0(){
  runApp(MaterialApp(
    title: '동계현장실습',
    home: Scaffold(
      appBar: AppBar(title: Text('동계현장실습'),),
      body: InputSample(),
    ),
  ));
}

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  late User _user;
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

  var nickname = " ";
  var gender = " ";
  var area = " ";
  var aboutMe = " ";


  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: CustomColors.firebaseWhite,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              SignInScreen();
            }
        ),
        backgroundColor: CustomColors.firebaseOrange,
        title: AppBarTitle(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
              _user.photoURL != null
                  ? ClipOval(
                child: Material(
                  color: CustomColors.firebaseBlack.withOpacity(0.3),
                  child: Image.network(
                    _user.photoURL!,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              )
                  : ClipOval(
                child: Material(
                  color: CustomColors.firebaseBlack.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: CustomColors.firebaseBlack,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.0),
              Text(
                '로그인 계정',
                style: TextStyle(
                  color: CustomColors.firebaseBlack,
                  fontSize: 26,
                ),
              ),

              SizedBox(height: 8.0),
              Text(
                _user.displayName!,
                style: TextStyle(
                  color: CustomColors.firebaseNavy,
                  fontSize: 26,
                ),
              ),

              SizedBox(height: 8.0),
              Text(
                '( ${_user.email!} )',
                style: TextStyle(
                  color: CustomColors.firebaseNavy,
                  fontSize: 20,
                  letterSpacing: 0.5,
                ),
              ),


              SizedBox(height: 24.0), // 닉네임
              Text(
                '닉네임: ${nickname}',
                style: TextStyle(
                    color: CustomColors.firebaseBlack.withOpacity(0.8),
                    fontSize: 14,
                    letterSpacing: 0.2),
              ),

              SizedBox(height: 24.0), // 성별
              Text(
                '성별: ${gender}',
                style: TextStyle(
                    color: CustomColors.firebaseBlack.withOpacity(0.8),
                    fontSize: 14,
                    letterSpacing: 0.2),
              ),


              SizedBox(height: 24.0), // 지역
              Text(
                '지역: ${area}',
                style: TextStyle(
                    color: CustomColors.firebaseBlack.withOpacity(0.8),
                    fontSize: 14,
                    letterSpacing: 0.2),
              ),


              SizedBox(height: 24.0), // 자기소개
              Text(
                '자기소개: ${aboutMe}',
                style: TextStyle(
                    color: CustomColors.firebaseBlack.withOpacity(0.8),
                    fontSize: 14,
                    letterSpacing: 0.2),
              ),




              SizedBox(height: 24.0),
              Text(
                'Google 계정을 사용하여 로그인했습니다.',
                style: TextStyle(
                    color: CustomColors.firebaseBlack.withOpacity(0.8),
                    fontSize: 14,
                    letterSpacing: 0.2),
              ),

              SizedBox(height: 8.0),
              ElevatedButton(onPressed: () async{
                DocumentSnapshot memberData = await fireStore.collection('member').doc(_user.uid).get();
                setState((){
                  nickname = memberData['nickname'];
                  gender = memberData['gender'];
                  area = memberData['area'];
                  aboutMe = memberData['aboutMe'];
                });
              },
                  child: Text('회원 정보 불러오기')
             ),

              SizedBox(height: 8.0),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                      return InputSample2();
                    }));
                  },
                  child: const Text('회원 정보 수정')
              ),

              SizedBox(height: 8.0),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                      return InputSample3();
                    }));
                  },
                  child: const Text('회원 탈퇴')
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
                    '로그아웃',
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
          ),
        ),
      ),
    );
  }
}