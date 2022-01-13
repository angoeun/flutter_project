
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_login_example/res/custom_colors.dart';
import 'package:google_login_example/screens/sign_in_screen.dart';
import 'package:google_login_example/screens/user_info_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// 회원 정보 입력 부분

Future<void> information() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: '동계현장실습',
    home: Scaffold(
      appBar: AppBar(title: Text('동계현장실습'),),
      body: InputSample(),
    ),
  ));
}

class InputSample extends StatefulWidget {
  @override
  State createState() => InputSampleState();
}

class InputSampleState extends State<InputSample> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  String nickname ="";
  final _valueList = ['없음', '여성', '남성'];
  var _selectdValue = '없음';
  String gender = "";
  String area = "";
  String aboutMe = "";

  final _formKey = GlobalKey<FormState>();


  final textController1 = TextEditingController();
  final textController2 = TextEditingController();
  final textController3 = TextEditingController();


  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    CollectionReference member = FirebaseFirestore.instance.collection('member');
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



        body: Form(
          key: _formKey,
          child:Column(
            children: <Widget>[
              Container(
                child: TextFormField(
                  controller: textController1,
                  style: TextStyle(fontSize: 16, color: CustomColors.firebaseGrey),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintText: '닉네임을 입력해 주세요.'),
                  onChanged: (value1) {
                    setState((){
                      nickname = value1;
                    });
                  },
                  validator: (nickname) {
                    if(nickname!.length < 1){
                      return '닉네임은 필수 입력 값입니다.';
                    }
                    return null;
                  },
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                width: 500,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text("성별     "),
                    ),
                    Container(
                      child: DropdownButtonFormField(
                        value: _selectdValue,
                        items: _valueList.map(
                              (value){
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                        onChanged: (value){
                          setState(() {
                            _selectdValue = value as String;
                          });
                        },
                        validator: (value){
                          if(value == _valueList[0]){
                            return '성별은 필수 입력 값입니다.';
                          }
                        },
                      ),
                      width: 300,
                    ),
                  ],
                ),
              ),
              Container(
                child: TextFormField(
                  controller: textController2,
                  style: TextStyle(fontSize: 16, color: CustomColors.firebaseGrey),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintText: '살고 있는 지역을 입력해 주세요.'),
                  onChanged: (value2) {
                    setState((){
                      area = value2;
                    });
                  },
                  validator: (area) {
                    if(area!.length < 1){
                      return '살고 있는 지역은 필수 입력 값입니다.';
                    }
                    return null;
                  },
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                width: 500,
              ),
              Container(
                child: TextFormField(
                  controller: textController3,
                  style: TextStyle(fontSize: 16, color: CustomColors.firebaseGrey),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintText: '자기소개를 입력해 주세요.'),
                  onChanged: (value3) {
                    setState((){
                      aboutMe = value3;
                    });
                  },
                  validator: (aboutMe) {
                    if(aboutMe!.length < 1){
                      return '닉네임은 필수 입력 값입니다.';
                    }
                    return null;
                  },
                ),
                padding: EdgeInsets.only(top: 10, bottom: 40),
                width: 500,
              ),



              ElevatedButton(
              onPressed: (){
                // 파이어베이스 데이터 넣는 부분
                fireStore.collection('member').doc(user.uid).set({
                  "nickname":nickname,
                  "gender":_selectdValue,
                  "area":area,
                  "aboutMe":aboutMe,
                });
                if(_formKey.currentState!.validate()) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          UserInfoScreen(
                            user: user,
                          ),
                    ),
                  );
                }
              },
            child: Text("회원가입 완료"),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    )
    );
  }
}