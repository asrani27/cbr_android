import 'dart:ui';

import 'package:cbr_android/api/bapok.dart';
import 'package:cbr_android/screen/dashboard.dart';
import 'package:cbr_android/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final _formState = GlobalKey<FormState>();
  bool _showPassword = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  Future _registerService() async {
    print('akses register');
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
      var response = await PostDataService().RegisterService(
          _usernameController.text,
          _passwordController.text,
          _nameController.text);

      print(response);
      if (response == false) {
        pd.close();
        Get.defaultDialog(
          title: 'Username sudah ada',
          content: Container(),
          textCancel: 'Exit',
        );
      } else if (response == true) {
        pd.close();
        Get.defaultDialog(
          title: 'Berhasil daftar, silahkan login',
          content: Container(
            child: TextButton(
              child: Text('Ke Login Page'),
              onPressed: () => {
                Get.offAll(() => login()),
              },
            ),
          ),
          textCancel: 'Exit',
        );
        //Get.offAll(() => login());
      } else {
        Get.offAll(() => login());
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
                  _buildNama(),
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
                  ),
                  _buildTextButton(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNama() => TextFormField(
        validator: (value) {
          if (value == '') {
            return "Nama tidak boleh kosong";
          }
          return null;
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple)),
          labelText: "Masukkan Nama Lengkap",
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(),
        ),
        controller: _nameController,
      );

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
          _registerService();
        }
      },
      icon: Icon(Icons.login_outlined),
      label: Text("Register"),
      style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50), primary: Colors.deepPurple));

  Widget _buildTextButton() => TextButton(
        child: Text('Kembali Ke Login Page'),
        onPressed: () {
          Get.offAll(() => login());
        },
      );
}
