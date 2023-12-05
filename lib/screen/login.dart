import 'dart:ui';

import 'package:cbr_android/api/bapok.dart';
import 'package:cbr_android/screen/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _formState = GlobalKey<FormState>();
  bool _showPassword = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future _LoginService() async {
    print('akses login');
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
        max: 100,
        msg: "Please wait...",
        hideValue: true,
        progressType: ProgressType.valuable,
        backgroundColor: Color(0xff212121),
        progressValueColor: Color(0xff3550B4),
        progressBgColor: Colors.white70,
        msgColor: Colors.white,
        valueColor: Colors.white);
    try {
      var response = await PostDataService()
          .LoginService(_usernameController.text, _passwordController.text);

      if (response == null) {
        pd.close();
        Get.defaultDialog(
          title: 'Username/Password tidak ditemukan',
          content: Container(),
          textCancel: 'Exit',
        );
      } else if (response == 401) {
        pd.close();
        Get.defaultDialog(
          title: 'Tidak bisa akses ke server',
          content: Container(),
          textCancel: 'Exit',
        );
      } else {
        Get.offAll(() => dashboard());
      }
    } catch (e) {
      pd.close();
      Get.defaultDialog(
        title: 'Gagal Akses, Check Internet Anda',
        content: Container(),
        textCancel: 'Exit',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.purple[100]!])),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Center(
                      child: Image.asset(
                        'assets/images/cbr.png',
                        width: screenWidth * 0.4,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildUsername(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildPassword(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildLogin(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  )
                  // _buildForgetPassword(),
                  // SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUsername() => TextFormField(
        validator: (value) {
          if (value == '') {
            return "username tidak boleh kosong";
          }
          return null;
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple)),
          labelText: "Username",
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(),
        ),
        controller: _usernameController,
      );
  Widget _buildPassword() => TextFormField(
        validator: (value) {
          if (value == '') {
            return "password tidak boleh kosong";
          }
          return null;
        },
        controller: _passwordController,
        obscureText: !_showPassword,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple)),
          labelText: 'Password',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
          ),
        ),
      );
  Widget _buildLogin() => ElevatedButton.icon(
      onPressed: () {
        if (_formState.currentState!.validate()) {
          _LoginService();
        }
      },
      icon: Icon(Icons.login_outlined),
      label: Text("Masuk"),
      style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50), primary: Colors.deepPurple));
}
