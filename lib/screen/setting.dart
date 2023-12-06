import 'package:cbr_android/api/bapok.dart';
import 'package:cbr_android/screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class setting extends StatefulWidget {
  const setting({super.key});

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  final _formState = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();

  Future _logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    Get.offAll(() => splash());
  }

  Future _gantiPassword() async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
      barrierDismissible: true,
      msg: "Please waiting...",
      hideValue: true,
    );
    var response =
        await PostDataService().gantiPassword(_passwordController.text);
    //Get.back();
    pd.close();
    print(['hasil', response]);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    Get.offAll(() => splash());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text('Setting'),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: ListTile(
              leading: Icon(
                Icons.lock_outline,
                color: Colors.deepPurple,
              ),
              title: Text('Ganti Password'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Get.defaultDialog(
                  title: 'Ganti Password',
                  radius: 5,
                  content: Container(
                    child: Form(
                      key: _formState,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == '') {
                                return "tidak boleh kosong";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple)),
                              labelText: 'New Password',
                              //hintText: dataKomoditi[index]['harga'],
                              prefixIcon: Icon(Icons.lock_outline),
                              border: OutlineInputBorder(),
                            ),
                            controller: _passwordController,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              if (_formState.currentState!.validate()) {
                                _gantiPassword();
                              }
                            },
                            icon: Icon(Icons.save_rounded),
                            label: Text("Update"),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(50),
                                primary: Colors.deepPurple),
                          ),
                        ],
                      ),
                    ),
                  ),
                  confirmTextColor: Colors.white,
                );
              },
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Card(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: ListTile(
              leading: Icon(
                Icons.logout_rounded,
                color: Colors.deepPurple,
              ),
              title: Text('Logout'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Get.defaultDialog(
                    title: "Anda ingin keluar dari aplikasi ?",
                    content: Container(),
                    textConfirm: 'Ya',
                    textCancel: 'Tidak',
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      _logout();
                    },
                    onCancel: () {
                      print('tidak');
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
