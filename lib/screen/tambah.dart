import 'package:cbr_android/api/bapok.dart';
import 'package:cbr_android/screen/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:async';

class tambah extends StatefulWidget {
  const tambah({super.key});

  @override
  State<tambah> createState() => _tambahState();
}

class _tambahState extends State<tambah> {
  final _formState = GlobalKey<FormState>();
  var selectedValue;
  var dataCiri;
  List categoryItemlist = [];
  var dropdownvalue;

  Future _tambahService() async {
    print(['id askdjasdas', selectedValue, dropdownvalue]);
    if (dropdownvalue == null) {
      Get.defaultDialog(
        title: 'Harap pilih',
        content: Container(),
        textCancel: 'Exit',
      );
    } else {
      var response = await PostDataService().TambahService(dropdownvalue);
      if (response == true) {
        Get.defaultDialog(
          title: 'Berhasil di tambahkan',
          content: Container(
            child: TextButton(
              child: Text('Ke Dashboard'),
              onPressed: () {
                Get.offAll(() => dashboard());
              },
            ),
          ),
          textCancel: 'Exit',
        );
      } else {
        Get.defaultDialog(
          title: 'Ciri ini sudah di tambahkan',
          content: Container(),
          textCancel: 'Exit',
        );
      }
      print(response);
    }
    // print(response);
  }

  Future _dataCiri() async {
    var baseUrl = "http://10.0.2.2:8000/api/ciri/";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = convert.jsonDecode(response.body);
      print(jsonData);
      setState(() {
        categoryItemlist = jsonData;
      });
    }
  }

  @override
  void initState() {
    //getAllCategory();
    _dataCiri();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text('Tambah Data'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: DropdownButtonFormField(
                validator: (value) {
                  if (value == null) {
                    return 'tolong pilih';
                  }
                  return null;
                },
                hint: Text('-pilih ciri-'),
                items: categoryItemlist.map((item) {
                  return DropdownMenuItem(
                    value: item['id'].toString(),
                    child: Text(item['nama'].toString()),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    dropdownvalue = newVal;
                    print(dropdownvalue);
                  });
                },
                value: dropdownvalue,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton.icon(
                  onPressed: () {
                    _tambahService();
                  },
                  icon: Icon(Icons.send),
                  label: Text("Simpan"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      primary: Colors.deepPurple)),
            ),
          ],
        ),
      ),
    );
  }
}
